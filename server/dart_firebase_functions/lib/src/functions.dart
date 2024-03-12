import 'package:dart_firebase_admin/dart_firebase_admin.dart';

import 'dart_firebase_functions/annotations.dart';
import 'dart_firebase_functions/firebase_functions.dart';

FirebaseAdminApp initializeAdminApp() => FirebaseAdminApp.initializeApp(
      'project-id',
      Credential.fromServiceAccountParams(
        clientId: 'client-id',
        privateKey: 'private-key',
        email: 'email',
      ),
    );

@OnDocumentCreated('todos/{todoId}')
Future<void> oncreatetodo(
  ({String todoId}) params,
  QueryDocumentSnapshot data,
) async {
  final todoId = params.todoId;
  final snapshot = data;
}

@OnDocumentUpdated('todos/{todoId}')
Future<void> onupdatetodo(({String todoId}) params, Change data) async {
  final todoId = params.todoId;
  final before = data.before;
  final after = data.after;
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}')
Future<void> oncreatelog(
  ({String todoId, String logId}) params,
  QueryDocumentSnapshot data,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final snapshot = data;
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}/foos/{fooId}')
Future<void> oncreatefoo(
  ({String todoId, String logId, String fooId}) params,
  QueryDocumentSnapshot data,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final fooId = params.fooId;
  final snapshot = data;
}
