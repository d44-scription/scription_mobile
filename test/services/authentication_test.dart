import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/services/authentication.service.dart';
import 'package:scription_mobile/http-common.dart';

void main() async {
  group('Authentication service', () {
    DioAdapter dioAdapter;

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    test('logging in unsuccessfully', () async {
      Http().aToken = '';

      dioAdapter
          .onPost('/users/login')
          .reply(422, {}, headers: {'set-cookie': []});

      // Confirm auth token is not set
      expect(AuthenticationService().login('Test email', 'test password'),
          throwsException);

      expect(Http().aToken, '');
    });

    test('when login stored by Http module', () async  {
      Http().aToken = 'XYZ';

      // Confirm positive result is returned from isLoggedIn
      expect(await AuthenticationService().isLoggedIn(), true);
    });
  });
}
