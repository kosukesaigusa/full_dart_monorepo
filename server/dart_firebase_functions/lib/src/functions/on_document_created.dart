// NOTE: https://github.com/firebase/firebase-functions/pull/1370

import 'package:functions_framework/functions_framework.dart';

import 'firebase_functions.dart';

// **************************************************************************
// Generated codes
// **************************************************************************

class OnTodoDocumentCreatedEvent {
  factory OnTodoDocumentCreatedEvent.fromCloudEvent(CloudEvent event) {
    final path = subjectPathFromCloudEvent(event);
    const params = (todoId: '');
    final snapshot = QueryDocumentSnapshotBuilder().build(event);
    return OnTodoDocumentCreatedEvent._(params: params, data: snapshot);
  }
  const OnTodoDocumentCreatedEvent._({
    required this.params,
    required this.data,
  });

  final ({String todoId}) params;

  final QueryDocumentSnapshot? data;
}

class OnLogDocumentTodosCollectionCreatedEvent {
  const OnLogDocumentTodosCollectionCreatedEvent({
    required this.params,
    required this.data,
  });

  final ({String todoId, String logId}) params;

  final QueryDocumentSnapshot? data;
}

class OnFooDocumentLogsCollectionTodosCollectionCreatedEvent {
  const OnFooDocumentLogsCollectionTodosCollectionCreatedEvent({
    required this.params,
    required this.data,
  });

  final ({String todoId, String logId, String fooId}) params;

  final QueryDocumentSnapshot? data;
}
