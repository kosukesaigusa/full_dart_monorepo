import 'package:dart_firebase_admin/firestore.dart' as admin;
import 'package:functions_framework/functions_framework.dart';

import '../../dart_firebase_functions.dart' as proto;

enum FirestoreDocumentEventType { v1Created, v1Updated, v1Deleted, v1Written }

sealed class FirestoreTriggeredEvent {
  const FirestoreTriggeredEvent({
    required this.id,
    required this.path,
    required this.eventType,
  });

  final String id;

  final String path;

  final FirestoreDocumentEventType eventType;
}

class DocumentCreatedEvent extends FirestoreTriggeredEvent {
  const DocumentCreatedEvent._({
    required super.id,
    required super.path,
    required super.eventType,
    required this.value,
  });

  factory DocumentCreatedEvent.fromCloudEvent({
    required admin.Firestore firestore,
    required CloudEvent event,
  }) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    return DocumentCreatedEvent._(
      id: _documentIdFromCloudEvent(event),
      path: _subjectPathFromCloudEvent(event),
      eventType: FirestoreDocumentEventType.v1Created,
      value: EventTriggeredDocument.fromDocument(
        firestore: firestore,
        document: documentEventData.value,
      ),
    );
  }

  final EventTriggeredDocument value;
}

class DocumentUpdatedEvent extends FirestoreTriggeredEvent {
  const DocumentUpdatedEvent._({
    required super.id,
    required super.path,
    required super.eventType,
    required this.value,
    required this.oldValue,
  });

  factory DocumentUpdatedEvent.fromCloudEvent({
    required admin.Firestore firestore,
    required CloudEvent event,
  }) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    return DocumentUpdatedEvent._(
      id: _documentIdFromCloudEvent(event),
      path: _subjectPathFromCloudEvent(event),
      eventType: FirestoreDocumentEventType.v1Updated,
      value: EventTriggeredDocument.fromDocument(
        firestore: firestore,
        document: documentEventData.value,
      ),
      oldValue: EventTriggeredDocument.fromDocument(
        firestore: firestore,
        document: documentEventData.oldValue,
      ),
    );
  }

  final EventTriggeredDocument value;

  final EventTriggeredDocument oldValue;
}

class DocumentDeletedEvent extends FirestoreTriggeredEvent {
  const DocumentDeletedEvent._({
    required super.id,
    required super.path,
    required super.eventType,
    required this.oldValue,
  });

  factory DocumentDeletedEvent.fromCloudEvent({
    required admin.Firestore firestore,
    required CloudEvent event,
  }) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    return DocumentDeletedEvent._(
      id: _documentIdFromCloudEvent(event),
      path: _subjectPathFromCloudEvent(event),
      eventType: FirestoreDocumentEventType.v1Deleted,
      oldValue: EventTriggeredDocument.fromDocument(
        firestore: firestore,
        document: documentEventData.oldValue,
      ),
    );
  }

  final EventTriggeredDocument oldValue;
}

class DocumentWrittenEvent extends FirestoreTriggeredEvent {
  const DocumentWrittenEvent._({
    required super.id,
    required super.path,
    required super.eventType,
    required this.value,
    required this.oldValue,
  });

  factory DocumentWrittenEvent.fromCloudEvent({
    required admin.Firestore firestore,
    required CloudEvent event,
  }) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    final value = documentEventData.value;
    final oldValue = documentEventData.oldValue;
    return DocumentWrittenEvent._(
      id: _documentIdFromCloudEvent(event),
      path: _subjectPathFromCloudEvent(event),
      eventType: FirestoreDocumentEventType.v1Written,
      value: value.hasName()
          ? EventTriggeredDocument.fromDocument(
              firestore: firestore,
              document: value,
            )
          : null,
      oldValue: oldValue.hasName()
          ? EventTriggeredDocument.fromDocument(
              firestore: firestore,
              document: oldValue,
            )
          : null,
    );
  }

  final EventTriggeredDocument? value;

  final EventTriggeredDocument? oldValue;
}

class EventTriggeredDocument {
  EventTriggeredDocument._({
    required this.data,
    required this.createTime,
    required this.updateTime,
  });

  factory EventTriggeredDocument.fromDocument({
    required admin.Firestore firestore,
    required proto.Document document,
  }) =>
      EventTriggeredDocument._(
        data: {
          for (final field in document.fields.entries)
            field.key: _decodeValue(firestore: firestore, value: field.value),
        },
        createTime: admin.Timestamp.fromDate(document.createTime.toDateTime()),
        updateTime: admin.Timestamp.fromDate(document.updateTime.toDateTime()),
      );

  final Map<String, Object?> data;

  final admin.Timestamp createTime;

  final admin.Timestamp updateTime;
}

// documents/users/ghXNtePIFmdDOBH3iEMH
String _subjectFromCloudEvent(CloudEvent event) =>
    event.toJson()['subject'] as String;

// users/ghXNtePIFmdDOBH3iEMH
String _subjectPathFromCloudEvent(CloudEvent event) =>
    _subjectFromCloudEvent(event).replaceFirst('documents/', '');

// ghXNtePIFmdDOBH3iEMH
String _documentIdFromCloudEvent(CloudEvent event) =>
    _subjectPathFromCloudEvent(event).split('/').last;

Object? _decodeValue({
  required admin.Firestore firestore,
  required proto.Value value,
}) {
  if (value.hasStringValue()) {
    return value.stringValue;
  } else if (value.hasBooleanValue()) {
    return value.booleanValue;
  } else if (value.hasIntegerValue()) {
    return value.integerValue.toInt();
  } else if (value.hasDoubleValue()) {
    return value.doubleValue;
  } else if (value.hasTimestampValue()) {
    return value.timestampValue;
  } else if (value.hasReferenceValue()) {
    return firestore.doc(
      RegExp(r'^projects\/([^/]*)\/databases\/([^/]*)(?:\/documents\/)?([\s\S]*)$')
          .firstMatch(value.referenceValue)!
          .group(3)!,
    );
  } else if (value.hasArrayValue()) {
    return [
      for (final value in value.arrayValue.values)
        _decodeValue(firestore: firestore, value: value),
    ];
  } else if (value.hasMapValue()) {
    final fields = value.mapValue.fields;
    return <String, Object?>{
      for (final entry in fields.entries)
        entry.key: _decodeValue(firestore: firestore, value: entry.value),
    };
  } else if (value.hasGeoPointValue()) {
    return admin.GeoPoint(
      latitude: value.geoPointValue.latitude,
      longitude: value.geoPointValue.longitude,
    );
  } else if (value.hasNullValue()) {
    return null;
  }

  throw ArgumentError.value(
    value,
    'value',
    'Cannot decode type from Firestore Value: ${value.runtimeType}',
  );
}
