import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/services/authentication.service.dart';
import 'package:scription_mobile/http-common.dart';

void main() async {
  group('Authentication service', () {
    DioAdapter dioAdapter;

    setUpAll(() {
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    group('logging in', () {
      test('successfully', () async {
        dioAdapter.onPost('/users/login').reply(200, {}, headers: {
          'set-cookie': ['Token: 12345']
        });

        await AuthenticationService().login('Test email', 'test password');

        expect(Http().aToken, 'Token: 12345');
      });
    });
  });
}
