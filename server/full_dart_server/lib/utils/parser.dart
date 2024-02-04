import 'package:dart_firebase_admin/firestore.dart' as admin;
import 'package:functions_framework/functions_framework.dart';
import 'package:protobuf_helpers_for_functions/protobuf_helpers_for_functions.dart'
    as proto;

// google.cloud.firestore.document.v1.updated
String eventType(CloudEvent event) => event.type;

// documents/users/ghXNtePIFmdDOBH3iEMH
String subjectFromCloudEvent(CloudEvent event) =>
    event.toJson()['subject'] as String;

// users/ghXNtePIFmdDOBH3iEMH
String subjectPathFromCloudEvent(CloudEvent event) =>
    subjectFromCloudEvent(event).replaceFirst('documents/', '');

// ghXNtePIFmdDOBH3iEMH
String documentIdFromCloudEvent(CloudEvent event) =>
    subjectPathFromCloudEvent(event).split('/').last;

class CreatedDocument {
  CreatedDocument._({
    required this.data,
    required this.createTime,
    required this.updateTime,
  });

  factory CreatedDocument.fromCloudEvent({
    required admin.Firestore firestore,
    required CloudEvent event,
  }) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    return CreatedDocument._(
      data: {
        for (final field in documentEventData.value.fields.entries)
          field.key: _decodeValue(firestore: firestore, value: field.value),
      },
      createTime: admin.Timestamp.fromDate(
        documentEventData.value.createTime.toDateTime(),
      ),
      updateTime: admin.Timestamp.fromDate(
        documentEventData.value.updateTime.toDateTime(),
      ),
    );
  }

  final Map<String, Object?> data;

  final admin.Timestamp createTime;

  final admin.Timestamp updateTime;
}

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
    'proto',
    'Cannot decode type from Firestore Value: ${value.runtimeType}',
  );
}
