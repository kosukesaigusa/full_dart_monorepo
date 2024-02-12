import 'dart:convert';
import 'dart:io';

import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:functions_framework/functions_framework.dart';

import '../utils/parser.dart';

class OnCreateTodoFunction {
  const OnCreateTodoFunction({
    required this.firestore,
    required this.auth,
    required this.event,
    required this.context,
  });

  final Firestore firestore;

  final Auth auth;

  final CloudEvent event;

  final RequestContext context;

  Future<void> call() async {
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
}
