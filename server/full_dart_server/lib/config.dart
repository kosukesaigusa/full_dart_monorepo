import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';

final _adminApp = FirebaseAdminApp.initializeApp(
  'project-id-here',
  Credential.fromServiceAccountParams(
    clientId: 'client-id-here',
    privateKey: 'private-key-here',
    email: 'client-email-here',
  ),
);

final firestore = Firestore(_adminApp);
