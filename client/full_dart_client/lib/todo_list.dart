import 'package:firestore_document_models/firestore_document_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list.g.dart';

@riverpod
TodoQuery todoQuery(TodoQueryRef _) => TodoQuery();

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() => ref.watch(todoQueryProvider).fetchDocuments();

  Future<void> addTodo(String title) async {
    await ref
        .read(todoQueryProvider)
        .add(createTodoData: CreateTodoData(title: title));
    ref.invalidateSelf();
  }

  Future<void> updateCompletionStatus({
    required String todoId,
    required bool isCompleted,
  }) async {
    await ref.read(todoQueryProvider).update(
          todoId: todoId,
          updateTodoData: UpdateTodoData(isCompleted: isCompleted),
        );
    ref.invalidateSelf();
  }

  Future<void> delete(String todoId) async {
    await ref.read(todoQueryProvider).delete(todoId: todoId);
    ref.invalidateSelf();
  }

  Future<void> completeAll() async {
    final todoIds =
        (await ref.read(todoListProvider.future)).map((todo) => todo.todoId);
    await ref.read(todoQueryProvider).batchWrite(
          todoIds
              .map(
                (todoId) => BatchUpdateTodo(
                  todoId: todoId,
                  updateTodoData: const UpdateTodoData(isCompleted: true),
                ),
              )
              .toList(),
        );
    ref.invalidateSelf();
  }

  Future<void> deleteAll() async {
    final todoIds =
        (await ref.read(todoListProvider.future)).map((todo) => todo.todoId);
    await ref.read(todoQueryProvider).batchWrite(
          todoIds.map((todoId) => BatchDeleteTodo(todoId: todoId)).toList(),
        );
    ref.invalidateSelf();
  }

  Future<int?> countNotCompletedTodos() => ref.read(todoQueryProvider).count(
        queryBuilder: (query) => query.where('isCompleted', isNotEqualTo: true),
      );
}
