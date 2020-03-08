import 'dart:async';
import 'package:dio/dio.dart';
import 'package:kosmeality/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String API_USER_ID = ':userId';
const String API_ADHERENTS_BASE_URL = '/mobile/particulier/v3/adherents';

class Api {
  factory Api() {
    return _singleton;
  }
  Api._internal();

  static final Api _singleton = Api._internal();

  Dio dio;
  bool _initialized = false;

  Future<void> _init() async {
    if (!_initialized) {
      dio = Dio(); // Set default configs

      dio.options.baseUrl = "https://kosmeality-api-avril.herokuapp.com";
      // dio.options .baseUrl = BASE_URL_VAL;
      dio.options.connectTimeout = 20000;
      dio.options.receiveTimeout = 20000;

      _initialized = true;
    }
  }

  /// Makes a get request for [url]
  ///
  /// Set [refresh] to true to ignore cache
  Future<dynamic> getRequest(String url, {Map<String, dynamic> queryParameters, bool refresh = false, int timeout}) async {
    await _init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers['x-access-token'] = prefs.getString('token');
    final Response<dynamic> response = await dio
        .get(
      url,
      queryParameters: queryParameters,
    )
        .catchError((dynamic e) {
      print(e);
    });

    return ApiResponse.fromJson(response.data);
  }

  /// Makes a get request for [url]
  ///
  /// Set [refresh] to true to ignore cache
  Future<dynamic> postRequest(String url, dynamic data, {Map<String, dynamic> queryParameters}) async {
    await _init();

    final Response<dynamic> response = await dio
        .post(
          url,
          data: data,
          queryParameters: queryParameters,
        )
        .catchError((dynamic e) {});

    return ApiResponse.fromJson(response.data);
  }
}
