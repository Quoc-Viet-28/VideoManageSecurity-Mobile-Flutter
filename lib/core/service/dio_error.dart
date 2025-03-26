import 'package:dio/dio.dart';

class DioErrorHandler {
  static String getErrorMessage(DioException error) {
    String errorMessage = 'không thành công';

    final response = error.response;
    if (response != null && response.data != null) {
      final responseData = response.data;
      if (responseData['message'] != null) {
        if (responseData['message'] is List) {
          errorMessage = responseData['message'].join('\n');
        } else {
          errorMessage = responseData['message'].toString();
        }
      }
    }

    return errorMessage;
  }
}
