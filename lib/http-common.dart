import 'package:dio/dio.dart';

class Http {
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
    }));
  }
}
