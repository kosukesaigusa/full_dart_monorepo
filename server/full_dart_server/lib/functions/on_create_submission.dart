import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:functions_framework/functions_framework.dart';

import '../utils/parser.dart';

class OnCreateSubmissionFunction {
  const OnCreateSubmissionFunction({
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
    final submittedByUserId =
        documentCreatedEvent.value.data['submittedByUserId'] as String?;
    if (submittedByUserId != null) {
      await firestore
          .collection('submissions')
          .doc(documentId)
          .update({'isVerified': true});
      context.logger.debug(
        'submission $documentId submitted by $submittedByUserId is verified',
      );
    } else {
      context.logger.debug(
        '''submission $documentId is not verified because submittedByUserId is null''',
      );
    }
  }
}
