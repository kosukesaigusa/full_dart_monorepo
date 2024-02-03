import 'package:dart_firebase_admin/firestore.dart';
import 'package:functions_framework/functions_framework.dart';

import '../config.dart';

// google.cloud.firestore.document.v1.updated
String eventType(CloudEvent event) => event.type;

// documents/users/ghXNtePIFmdDOBH3iEMH
String subjectFromCloudEvent(CloudEvent event) =>
    event.toJson()['subject'] as String;

// users/ghXNtePIFmdDOBH3iEMH
String subjectPathFromCloudEvent(CloudEvent event) =>
    subjectFromCloudEvent(event).replaceFirst('documents/', '');

// ghXNtePIFmdDOBH3iEMH
String documentIdFromCloudEvent(CloudEvent event) =>
    subjectPathFromCloudEvent(event).split('/').last;

DocumentSnapshot<Map<String, Object?>> fromJson({
  required CloudEvent event,
  required Map<String, dynamic> json,
}) {
  final ref = firestore.doc(subjectPathFromCloudEvent(event));
  final UpdateMap updateMap = {
    FieldPath(const ['name']): json['name'],
    FieldPath(const ['fields', 'title']): json['title'],
    FieldPath(const ['createTime']): json['createTime'],
    FieldPath(const ['updateTime']): json['updateTime'],
  };
  return DocumentSnapshot.fromUpdateMap(ref, updateMap);
}
