import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;
import 'package:scription_mobile/login.dart';
import 'package:scription_mobile/constants.dart' as Constants;

class Http {
  final _storage = new FlutterSecureStorage();
  Dio dio;
  String aToken = '';
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

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
      dio.interceptors.errorLock.lock();

      if ([401, 404].contains(error.response.statusCode)) {
        _instance.aToken = '';
        await _storage.delete(key: 'aToken');

        navigatorKey.currentState.pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Login(message: Constants.UNAUTHORISED)),
            (route) => false);
      }

      dio.interceptors.errorLock.unlock();
    }));
  }
}
