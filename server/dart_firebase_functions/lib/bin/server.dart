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
            const document = 'todos/{todoId}';
            final documentIds =
                FirestorePathParser(document).parse(event.subject!);
            final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
            return function_library
                .oncreatetodo((todoId: documentIds['todoId']!), data.snapshot);
          },
        ),
      'onupdatetodo' => FunctionTarget.cloudEvent(
          (event) {
            const document = 'todos/{todoId}';
            final documentIds =
                FirestorePathParser(document).parse(event.subject!);
            final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
            return function_library
                .onupdatetodo((todoId: documentIds['todoId']!), data.change);
          },
        ),
      _ => null
    };
