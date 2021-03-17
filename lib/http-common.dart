import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;

class Http {
  final _storage = new FlutterSecureStorage();
  Dio dio;
  String aToken = '';

  final BaseOptions options = new BaseOptions(
    baseUrl: 'https://scription-api-staging.herokuapp.com/api/v1',
    connectTimeout: 15000,
    receiveTimeout: 13000,
  );

  static final Http _instance = Http._internal();

  factory Http() => _instance;

  Http._internal() {
    dio = Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      dio.interceptors.requestLock.lock();

      // Set the cookie in request headers
      options.headers['cookie'] = aToken;

      dio.interceptors.requestLock.unlock();
      return options;
    }, onError: (DioError error) async {
      // If request returns a 401 error, remove stored auth tokens
      if (error.response.statusCode == 401) {
        _instance.aToken = '';
        await _storage.delete(key: 'aToken');
      }
    }));
  }
}
