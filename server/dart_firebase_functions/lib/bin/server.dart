import 'package:functions_framework/serve.dart';

import '../src/dart_firebase_functions/firebase_functions.dart';
import '../src/dart_firebase_functions/firestore_path_parser.dart';
import '../src/functions.dart' as function_library;

Future<void> main(List<String> args) async {
  final app = function_library.initializeAdminApp();
  FirebaseFunctions.initialize(app);
  await serve(args, _nameToFunctionTarget);
}

FunctionTarget? _nameToFunctionTarget(String name) => switch (name) {
      'oncreatetodo' => FunctionTarget.cloudEvent(
          (event) {
            final documentIds =
                FirestorePathParser('todos/{todoId}').parse(event.subject!);
            return function_library.onCreateTodo(
              (todoId: documentIds['todoId']!),
              QueryDocumentSnapshotBuilder().onCreated(event),
            );
          },
        ),
      'onupdatetodo' => FunctionTarget.cloudEvent(
          (event) {
            final documentIds =
                FirestorePathParser('todos/{todoId}').parse(event.subject!);
            return function_library.onUpdateTodo(
              (todoId: documentIds['todoId']!),
              QueryDocumentSnapshotBuilder().onUpdated(event),
            );
          },
        ),
      _ => null
    };
