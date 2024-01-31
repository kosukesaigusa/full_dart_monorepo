import 'package:functions_framework/functions_framework.dart';
import 'package:protobuf_helpers_for_functions/protobuf_helpers_for_functions.dart';

import 'config.dart';

@CloudFunction()
Future<void> oncreateuser(CloudEvent event, RequestContext context) async {
  final documentEventData =
      DocumentEventData.fromBuffer(event.data! as List<int>);
  final json = documentEventData.toProto3Json()! as Map<String, dynamic>;
  final documentId = ((json['value'] as Map<String, dynamic>)['name'] as String)
      .split('/')
      .last;
  final message = (((json['value'] as Map<String, dynamic>)['fields']
      as Map?)?['message'] as Map?)?['stringValue'] as String?;

  context.logger.info('created documentId: $documentId');
  context.logger.info('created message: $message');

  final documentSnapshot =
      await firestore.collection('users').doc(documentId).get();
  await documentSnapshot.ref.update({
    'message': '$message from server!',
  });
}
