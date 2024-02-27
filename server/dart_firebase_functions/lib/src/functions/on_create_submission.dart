import 'on_document_created.dart';

@OnDocumentCreated('todos/{todoId}')
Future<void> onCreateTodo(OnTodoDocumentCreatedEvent event) async {
  final todoId = event.params.todoId;
  final snapshot = event.data;
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}')
Future<void> onCreateLog(
  OnLogDocumentTodosCollectionCreatedEvent event,
) async {
  final todoId = event.params.todoId;
  final logId = event.params.logId;
  final snapshot = event.data;
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}/foos/{fooId}')
Future<void> onCreateFoo(
  OnFooDocumentLogsCollectionTodosCollectionCreatedEvent event,
) async {
  final todoId = event.params.todoId;
  final logId = event.params.logId;
  final fooId = event.params.fooId;
  final snapshot = event.data;
}
