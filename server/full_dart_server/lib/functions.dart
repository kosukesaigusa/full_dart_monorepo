import 'dart:convert';
import 'dart:io';

import 'package:functions_framework/functions_framework.dart';
import 'package:protobuf_helpers_for_functions/protobuf_helpers_for_functions.dart';

import 'config.dart';

@CloudFunction()
Future<void> oncreatetodo(CloudEvent event, RequestContext context) async {
  context.logger.debug('oncreatetodo function triggered');
  final documentEventData =
      DocumentEventData.fromBuffer(event.data! as List<int>);
  final json = documentEventData.toProto3Json()! as Map<String, dynamic>;
  stdout.writeln(jsonEncode(json));
  final documentId = ((json['value'] as Map<String, dynamic>)['name'] as String)
      .split('/')
      .last;
  final title = (((json['value'] as Map<String, dynamic>)['fields']
      as Map?)?['title'] as Map?)?['stringValue'] as String?;

  context.logger.info('created documentId: $documentId');
  context.logger.info('created title: $title');

  final documentSnapshot =
      await firestore.collection('todos').doc(documentId).get();
  await documentSnapshot.ref.update({
    'title': '$title from server!',
  });
  stdout.writeln(jsonEncode(event.toJson()));
  stdout.writeln(jsonEncode(context.request.headers));
  stdout.writeln(jsonEncode(context.responseHeaders));
  context.logger.debug(jsonEncode(context.request.method));
}
