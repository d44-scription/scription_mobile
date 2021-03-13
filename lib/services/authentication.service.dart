import 'package:scription_mobile/http-common.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  final _storage = new FlutterSecureStorage();

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
      final token = cookies[0].split(';')[0];

      // Save cookie to global variable to include it in future API calls
      Http().aToken = token;
      await _storage.write(key: 'aToken', value: token);
    }
  }

  Future<bool> isLoggedIn() async {
    // If http-common module already has aToken set, confirm logged in
    if (Http().aToken != '') return true;

    // Otherwise, if storage contains key then set it in http-common and return true
    if (await _storage.containsKey(key: 'aToken')) {
      final token = await _storage.read(key: 'aToken');
      Http().aToken = token;

      return true;
    }

    // If key is not in storage or in Http, user is not logged in
    return false;
  }
}
