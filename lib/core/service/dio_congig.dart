// ignore_for_file: body_might_complete_normally_catch_error, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/service/pref_utils.dart';
import '../../../core/service/token.dart';
import 'auth_service.dart';

class DioConfig {
  // Khai báo một biến static để sử dụng singleton pattern
  static final DioConfig _instance = DioConfig._internal();

  // Khai báo một biến dio để lưu trữ đối tượng Dio
  late Dio dio;

  // token
  GetBearerToken getToken = GetBearerToken();

  // Hàm khởi tạo nội bộ
  DioConfig._internal() {
    // Tạo một đối tượng Dio mới
    dio = Dio();

    // Header mặc định cho các yêu cầu
    dio.options.baseUrl = dotenv.env['SERVER_DOMAIN']! + dotenv.env['API_BASE_PATH']!;
    log("BASE URL: ${dio.options.baseUrl}");
    dio.options.connectTimeout =
        const Duration(seconds: 30); // Thời gian tối đa để kết nối
    dio.options.receiveTimeout =
        const Duration(seconds: 30); // Thời gian tối đa để nhận dữ liệu
    dio.options.headers = {"Content-Type": "application/json"};

    // Interceptor để in ra log của các yêu cầu và phản hồi
    // dio.interceptors.add(LogInterceptor());

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {

        log('${jsonEncode(options.method)} : ${jsonEncode(options.path)}');
        String token = await getToken.getToken();

        options.headers["Authorization"] = "Bearer $token";
        handler.next(options);
      },
      onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          TokenResponse? response =
              await Auth_Service.instance.refreshAccessToken();

          if (response.runtimeType == TokenResponse) {
            if (response?.accessToken != null) {
              // Cập nhật token mới vào headers và thực hiện lại request
              error.requestOptions.headers['Authorization'] =
                  'Bearer ${response?.accessToken}';

              final retryResponse = await dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data, // POST, PUT, PATCH
                queryParameters: error.requestOptions.queryParameters, // GET
              );

              return handler.resolve(retryResponse);
            }
          }
        }

        return handler.next(error);
      },
    ));
  }

  void deleteToken() {
    log('remove token');
    PrefUtils.clearPrefs();

    // navigatorKey.currentState
    //     ?.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    //
    // CustomDialog.showDialogWithoutContext(
    //     text: 'Bạn đã bị đăng xuất từ một thiết bị khác.', onSubmit: () {});
  }

  factory DioConfig() {
    return _instance;
  }
}
