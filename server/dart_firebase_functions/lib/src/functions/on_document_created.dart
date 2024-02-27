// NOTE: https://github.com/firebase/firebase-functions/pull/1370

/// published annotation
class OnDocumentCreated {
  const OnDocumentCreated(this.document);

  final String document;
}

/// QueryDocumentSnapshot
class QueryDocumentSnapshot {
  const QueryDocumentSnapshot();
}

// **************************************************************************
// Generated codes
// **************************************************************************

class OnSubmissionDocumentCreatedEvent {
  const OnSubmissionDocumentCreatedEvent({
    required this.params,
    required this.data,
  });

  final OnSubmissionDocumentCreatedEventParams params;

  final QueryDocumentSnapshot? data;
}

class OnSubmissionDocumentCreatedEventParams {
  String get submissionId => 'some-submissionId';
}

class OnTodoDocumentCreatedEvent {
  const OnTodoDocumentCreatedEvent({
    required this.params,
    required this.data,
  });

  final OnTodoDocumentCreatedEventParams params;

  final QueryDocumentSnapshot? data;
}

class OnTodoDocumentCreatedEventParams {
  String get todoId => 'some-todoId';
}

class OnLogDocumentTodosCollectionCreatedEvent {
  const OnLogDocumentTodosCollectionCreatedEvent({
    required this.params,
    required this.data,
  });

  final OnLogDocumentTodosCollectionCreatedEventParams params;

  final QueryDocumentSnapshot? data;
}

class OnLogDocumentTodosCollectionCreatedEventParams {
  String get todoId => 'some-todoId';

  String get logId => 'some-logId';
}

class OnFooDocumentLogsCollectionTodosCollectionCreatedEvent {
  const OnFooDocumentLogsCollectionTodosCollectionCreatedEvent({
    required this.params,
    required this.data,
  });

  final OnFooDocumentLogsCollectionTodosCollectionCreatedEventParams params;

  final QueryDocumentSnapshot? data;
}

class OnFooDocumentLogsCollectionTodosCollectionCreatedEventParams {
  String get todoId => 'some-todoId';

  String get logId => 'some-logId';

  String get fooId => 'some-fooId';
}
