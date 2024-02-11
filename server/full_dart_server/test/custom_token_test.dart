import 'package:test/test.dart';

import 'utils/config.dart';

void main() async {
  test('create customToken', () async {
    final customToken = await auth.createCustomToken('some-uid');
    print('customToken: $customToken');
  });
}
