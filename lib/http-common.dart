import 'package:dio/dio.dart';

class Http {
  Dio _dio;
  String aToken = '';

  final BaseOptions options = new BaseOptions(
    baseUrl: 'https://scription-api-staging.herokuapp.com/api/v1',
    connectTimeout: 15000,
    receiveTimeout: 13000,
  );

  static final Http _instance = Http._internal();

  factory Http() => _instance;

  Http._internal() {
    _dio = Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (Options options) async {
          // to prevent other request enter this interceptor.
          _dio.interceptors.requestLock.lock();
          // We use a new Dio (to avoid dead lock) instance to request token.
          // Set the cookie in request headers
          options.headers["cookie"] = aToken;

          _dio.interceptors.requestLock.unlock();
          return options;
        }
    ));
  }

  Future login() async {
    final params = {
      "user": {
        "email": "admin@example.com",
        "password": "superSecret123!",
      }
    };

    final response = await _dio.post('/users/login', data: params);

    // Get cookie from response
    final cookies = response.headers.map['set-cookie'];

    if (cookies.isNotEmpty && cookies.length == 1) {
      final authToken = cookies[0].split(';')[0];

      // Save cookie to global variable to include it in future API calls
      aToken = authToken;
    }
  }

  bool isLoggedIn() {
    return aToken != '';
  }

  /// If we call this function without cookie then it will be forbidden
  Future getNotebooks() async {
    final response = await _dio.get('/notebooks');

    print(response.data.toString());
  }
}
