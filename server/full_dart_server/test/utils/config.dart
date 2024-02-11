import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';

import 'test_environment_variable.dart';

final environmentVariable = TestEnvironmentVariable();

final _adminApp = FirebaseAdminApp.initializeApp(
  environmentVariable.projectId,
  Credential.fromServiceAccountParams(
    clientId: environmentVariable.clientId,
    privateKey: environmentVariable.privateKey,
    email: environmentVariable.clientEmail,
  ),
);

final firestore = Firestore(_adminApp);

final auth = Auth(_adminApp);
