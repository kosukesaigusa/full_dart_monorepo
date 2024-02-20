import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';

import 'config.dart';
import 'functions/create_firebase_auth_custom_token.dart';
import 'functions/on_create_submission.dart';
import 'functions/on_create_todo.dart';
import 'functions/on_delete_todo.dart';
import 'functions/on_update_todo.dart';
import 'functions/on_write_todo.dart';

@CloudFunction()
Response hello(Request request) => Response.ok('Hello, World!');

@CloudFunction()
Future<void> oncreatetodo(CloudEvent event, RequestContext context) =>
    OnCreateTodoFunction(
      firestore: firestore,
      auth: auth,
      event: event,
      context: context,
    ).call();

@CloudFunction()
Future<void> onupdatetodo(CloudEvent event, RequestContext context) =>
    OnUpdateTodoFunction(
      firestore: firestore,
      auth: auth,
      event: event,
      context: context,
    ).call();

@CloudFunction()
Future<void> ondeletetodo(CloudEvent event, RequestContext context) =>
    OnDeleteTodoFunction(
      firestore: firestore,
      auth: auth,
      event: event,
      context: context,
    ).call();

@CloudFunction()
Future<void> onwritetodo(CloudEvent event, RequestContext context) =>
    OnWriteTodoFunction(
      firestore: firestore,
      auth: auth,
      event: event,
      context: context,
    ).call();

@CloudFunction()
Future<void> oncreatesubmission(CloudEvent event, RequestContext context) =>
    OnCreateSubmissionFunction(
      firestore: firestore,
      auth: auth,
      event: event,
      context: context,
    ).call();

@CloudFunction()
Future<Response> createfirebaseauthcustomtoken(Request request) =>
    CreateFirebaseAuthCustomTokenFunction(
      firestore: firestore,
      auth: auth,
      request: request,
    ).call();
