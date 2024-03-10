import 'package:dart_firebase_functions/src/dart_firebase_functions/firestore_path_parser.dart';
import 'package:test/test.dart';

void main() {
  group('FirestorePathParser', () {
    test('Valid path matching pattern', () {
      final parser = FirestorePathParser('todos/{todoId}/logs/{logId}');
      final results = parser.parse('documents/todos/todo123/logs/log456');

      expect(results['todoId'], 'todo123');
      expect(results['logId'], 'log456');
    });

    test('Path does not match pattern', () {
      final parser = FirestorePathParser('todos/{todoId}/logs/{logId}');

      expect(
        () => parser.parse('documents/todos/todo123/logs'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Invalid pattern', () {
      expect(
        () => FirestorePathParser('todos/{todoId/logs/{logId}'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Extra segments in path', () {
      final parser = FirestorePathParser('todos/{todoId}');

      expect(
        () => parser.parse('documents/todos/todo123/extra'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Missing segments in path', () {
      final parser = FirestorePathParser('todos/{todoId}/logs/{logId}');

      expect(
        () => parser.parse('documents/todos/todo123'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
