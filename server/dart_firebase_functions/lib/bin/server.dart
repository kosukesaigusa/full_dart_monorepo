import 'package:functions_framework/serve.dart';

import '../src/functions/firebase_functions.dart';
import '../src/functions/functions.dart' as function_library;
import '../src/functions/on_document_created.dart';

Future<void> main(List<String> args) async {
  final app = function_library.initializeAdminApp();
  FirebaseFunctions.initialize(app);
  await serve(args, _nameToFunctionTarget);
}

FunctionTarget? _nameToFunctionTarget(String name) => switch (name) {
      'oncreatetodo' => FunctionTarget.cloudEvent(
          (event) => function_library
              .onCreateTodo(OnTodoDocumentCreatedEvent.fromCloudEvent(event)),
        ),
      _ => null
    };
