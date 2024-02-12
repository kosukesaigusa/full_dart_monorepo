// GENERATED CODE - DO NOT MODIFY BY HAND
// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:full_dart_server/functions.dart' as function_library;
import 'package:functions_framework/serve.dart';

Future<void> main(List<String> args) async {
  await serve(args, _nameToFunctionTarget);
}

FunctionTarget? _nameToFunctionTarget(String name) => switch (name) {
      'oncreatetodo' => FunctionTarget.cloudEventWithContext(
          function_library.oncreatetodo,
        ),
      'onupdatetodo' => FunctionTarget.cloudEventWithContext(
          function_library.onupdatetodo,
        ),
      'ondeletetodo' => FunctionTarget.cloudEventWithContext(
          function_library.ondeletetodo,
        ),
      'onwritetodo' => FunctionTarget.cloudEventWithContext(
          function_library.onwritetodo,
        ),
      'oncreatesubmission' => FunctionTarget.cloudEventWithContext(
          function_library.oncreatesubmission,
        ),
      'createfirebaseauthcustomtoken' => FunctionTarget.http(
          function_library.createfirebaseauthcustomtoken,
        ),
      _ => null
    };
