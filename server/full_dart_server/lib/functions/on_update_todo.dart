import 'dart:convert';
import 'dart:io';

import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:functions_framework/functions_framework.dart';

import '../utils/parser.dart';

class OnUpdateTodoFunction {
  const OnUpdateTodoFunction({
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
}
