import 'dart:convert';
import 'dart:io';

import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';

import 'config.dart';
import 'functions/create_firebase_auth_custom_token.dart';
import 'utils/parser.dart';

@CloudFunction()
Future<void> oncreatetodo(CloudEvent event, RequestContext context) async {
  final documentCreatedEvent = DocumentCreatedEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentCreatedEvent.id;
  final eventType = documentCreatedEvent.eventType;

  final title = documentCreatedEvent.value.data['title'] as String?;
  final documentSnapshot =
      await firestore.collection('todos').doc(documentId).get();
  await documentSnapshot.ref.update({'title': '$title from server!'});

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('event.data: ${event.data}');
}

@CloudFunction()
Future<void> onupdatetodo(CloudEvent event, RequestContext context) async {
  final documentUpdatedEvent = DocumentUpdatedEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentUpdatedEvent.id;
  final eventType = documentUpdatedEvent.eventType;

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('event.data: ${event.data}');
}

@CloudFunction()
Future<void> ondeletetodo(CloudEvent event, RequestContext context) async {
  final documentDeletedEvent = DocumentDeletedEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentDeletedEvent.id;
  final eventType = documentDeletedEvent.eventType;

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('event.data: ${event.data}');
}

@CloudFunction()
Future<void> onwritetodo(CloudEvent event, RequestContext context) async {
  final documentWrittenEvent = DocumentWrittenEvent.fromCloudEvent(
    firestore: firestore,
    event: event,
  );
  final documentId = documentWrittenEvent.id;
  final eventType = documentWrittenEvent.eventType;

  context.logger.debug('documentId: $documentId');
  context.logger.debug('eventType: $eventType');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln('event.data: ${event.data}');
}

@CloudFunction()
Future<Response> createfirebaseauthcustomtoken(Request request) =>
    CreateFirebaseAuthCustomTokenFunction(
      firestore: firestore,
      auth: auth,
      request: request,
    ).call();
