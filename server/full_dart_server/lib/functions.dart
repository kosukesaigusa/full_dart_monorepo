import 'dart:convert';
import 'dart:io';

import 'package:functions_framework/functions_framework.dart';

import 'config.dart';
import 'utils/parser.dart';

@CloudFunction()
Future<void> oncreatetodo(CloudEvent event, RequestContext context) async {
  final documentCreatedEvent = DocumentCreatedEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentCreatedEvent.id;
  final eventType = documentCreatedEvent.eventType;
  final json = documentCreatedEvent.value.data;

  final title = documentCreatedEvent.value.data['title'] as String?;
  final documentSnapshot =
      await firestore.collection('todos').doc(documentId).get();
  await documentSnapshot.ref.update({'title': '$title from server!'});

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('json: ${jsonEncode(json)}');
}

@CloudFunction()
Future<void> onupdatetodo(CloudEvent event, RequestContext context) async {
  final documentUpdatedEvent = DocumentUpdatedEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentUpdatedEvent.id;
  final eventType = documentUpdatedEvent.eventType;
  final beforeJson = documentUpdatedEvent.oldValue.data;
  final afterJson = documentUpdatedEvent.value.data;

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('beforeJson: ${jsonEncode(beforeJson)}');
  stdout.writeln('afterJson: ${jsonEncode(afterJson)}');
}

@CloudFunction()
Future<void> ondeletetodo(CloudEvent event, RequestContext context) async {
  final documentDeletedEvent = DocumentDeletedEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentDeletedEvent.id;
  final eventType = documentDeletedEvent.eventType;
  final json = documentDeletedEvent.oldValue.data;

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('json: ${jsonEncode(json)}');
}

@CloudFunction()
Future<void> onwritetodo(CloudEvent event, RequestContext context) async {
  final documentWrittenEvent = DocumentWrittenEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentWrittenEvent.id;
  final eventType = documentWrittenEvent.eventType;
  final beforeJson = documentWrittenEvent.oldValue?.data;
  final afterJson = documentWrittenEvent.value?.data;

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('beforeJson: ${jsonEncode(beforeJson)}');
  stdout.writeln('afterJson: ${jsonEncode(afterJson)}');
}
