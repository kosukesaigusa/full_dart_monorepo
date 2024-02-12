import 'package:dart_firebase_admin/messaging.dart';
import 'package:test/test.dart';

import 'utils/config.dart';

void main() async {
  test('create customToken', () async {
    final result = await messaging.send(
      TokenMessage(
        token:
            'cqHjpGvTQiud7aeoq6z-iH:APA91bHiU6vI5KUBc7cZP9Vv6UrPuYy9pSBATNfDTa8J691jsxKtv3_peVBoxvvrKOBqRW97ebqIkHuiqdFRq8LLiG_BIQBy7PSNDwWXzewRVh4Nq0LoQM5n1tH6ApYlQL4KxX4Jddb6',
        notification: Notification(
          title: 'Hello World',
          body: '${DateTime.now()}',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/2560px-Google-flutter-logo.svg.png',
        ),
      ),
    );
    print(result);
  });
}
