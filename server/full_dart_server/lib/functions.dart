import 'dart:convert';
import 'dart:io';

import 'package:functions_framework/functions_framework.dart';
import 'package:protobuf_helpers_for_functions/protobuf_helpers_for_functions.dart';

import 'config.dart';
import 'utils/parser.dart';

@CloudFunction()
Future<void> oncreatetodo(CloudEvent event, RequestContext context) async {
  context.logger.debug('oncreatetodo function is triggered');
  final documentEventData =
      DocumentEventData.fromBuffer(event.data! as List<int>);
  final json = documentEventData.toProto3Json()! as Map<String, dynamic>;
  stdout.writeln('json: ${jsonEncode(json)}');

  final createdDocument = CreatedDocument.fromCloudEvent(
    firestore: firestore,
    event: event,
  );

  final documentId = documentIdFromCloudEvent(event);
  final title = createdDocument.data['title'] as String?;

  final documentSnapshot =
      await firestore.collection('todos').doc(documentId).get();
  await documentSnapshot.ref.update({'title': '$title from server!'});
  context.logger.debug('subject: ${subjectFromCloudEvent(event)}');
  context.logger.debug('event.data: ${event.data}');
  stdout.writeln('event.toJson(): ${jsonEncode(event.toJson())}');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln(
    'context.responseHeaders: ${jsonEncode(context.responseHeaders)}',
  );
  context.logger
      .debug('context.request.method: ${jsonEncode(context.request.method)}');
}

@CloudFunction()
Future<void> onupdatetodo(CloudEvent event, RequestContext context) async {
  context.logger.debug('onupdatetodo function is triggered');
  final documentEventData =
      DocumentEventData.fromBuffer(event.data! as List<int>);
  final json = documentEventData.toProto3Json()! as Map<String, dynamic>;
  stdout.writeln('json: ${jsonEncode(json)}');

  context.logger.debug('subject: ${subjectFromCloudEvent(event)}');
  context.logger.debug('event.data: ${event.data}');
  stdout.writeln('event.toJson(): ${jsonEncode(event.toJson())}');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln(
    'context.responseHeaders: ${jsonEncode(context.responseHeaders)}',
  );
  context.logger
      .debug('context.request.method: ${jsonEncode(context.request.method)}');
}

@CloudFunction()
Future<void> ondeletetodo(CloudEvent event, RequestContext context) async {
  context.logger.debug('ondeletetodo function is triggered');
  final documentEventData =
      DocumentEventData.fromBuffer(event.data! as List<int>);
  final json = documentEventData.toProto3Json()! as Map<String, dynamic>;
  stdout.writeln('json: ${jsonEncode(json)}');

  context.logger.debug('subject: ${subjectFromCloudEvent(event)}');
  context.logger.debug('event.data: ${event.data}');
  stdout.writeln('event.toJson(): ${jsonEncode(event.toJson())}');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln(
    'context.responseHeaders: ${jsonEncode(context.responseHeaders)}',
  );
  context.logger
      .debug('context.request.method: ${jsonEncode(context.request.method)}');
}

@CloudFunction()
Future<void> onwritetodo(CloudEvent event, RequestContext context) async {
  context.logger.debug('onwritetodo function is triggered');
  final documentEventData =
      DocumentEventData.fromBuffer(event.data! as List<int>);
  final json = documentEventData.toProto3Json()! as Map<String, dynamic>;
  stdout.writeln('json: ${jsonEncode(json)}');

  context.logger.debug('subject: ${subjectFromCloudEvent(event)}');
  context.logger.debug('event.data: ${event.data}');
  stdout.writeln('event.toJson(): ${jsonEncode(event.toJson())}');
  stdout.writeln(
    'context.request.headers ${jsonEncode(context.request.headers)}',
  );
  stdout.writeln(
    'context.responseHeaders: ${jsonEncode(context.responseHeaders)}',
  );
  context.logger
      .debug('context.request.method: ${jsonEncode(context.request.method)}');
}
