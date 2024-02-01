import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';

import 'environment_variable.dart';

final _environmentVariable = EnvironmentVariable(EnvironmentProvider());

final _adminApp = FirebaseAdminApp.initializeApp(
  _environmentVariable.projectId,
  Credential.fromServiceAccountParams(
    clientId: _environmentVariable.clientId,
    privateKey: _environmentVariable.privateKey,
    email: _environmentVariable.clientEmail,
  ),
);

final firestore = Firestore(_adminApp);
