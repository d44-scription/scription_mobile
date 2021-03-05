import 'package:scription_mobile/http-common.dart';

class AuthenticationService {
  Future login(email, password) async {
    final params = {
      'user': {
        'email': email,
        'password': password,
      }
    };

    final response = await Http().dio.post('/users/login', data: params);

    // Get cookie from response
    final cookies = response.headers.map['set-cookie'];

    if (cookies.isNotEmpty && cookies.length == 1) {
      final authToken = cookies[0].split(';')[0];

      // Save cookie to global variable to include it in future API calls
      Http().aToken = authToken;
    }
  }
}
