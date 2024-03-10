import 'package:dart_firebase_admin/dart_firebase_admin.dart';

import 'dart_firebase_functions/annotations.dart';
import 'dart_firebase_functions/firebase_functions.dart';

FirebaseAdminApp initializeAdminApp() => FirebaseAdminApp.initializeApp(
      'project-id',
      throw UnimplementedError(),
    );

@OnDocumentCreated('todos/{todoId}')
Future<void> onCreateTodo(
  ({String todoId}) params,
  QueryDocumentSnapshot data,
) async {
  final todoId = params.todoId;
  final snapshot = data;
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}')
Future<void> onCreateLog(
  ({String todoId, String logId}) params,
  QueryDocumentSnapshot data,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final snapshot = data;
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}/foos/{fooId}')
Future<void> onCreateFoo(
  ({String todoId, String logId, String fooId}) params,
  QueryDocumentSnapshot data,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final fooId = params.fooId;
  final snapshot = data;
}
