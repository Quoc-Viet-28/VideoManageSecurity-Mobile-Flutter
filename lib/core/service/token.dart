import 'package:box_alarm/core/service/pref_utils.dart';
import 'package:dio/dio.dart';

class GetBearerToken {
  Future getToken() async {
    try {
      String? token = await PrefUtils.getToken();
      // print(token.toString());

      return token.toString();
    } on DioException catch (e) {
      // ignore: avoid_print
      print('get token err');
      return e.toString();
    }
  }

  Future getTokenExpired() async {
    try {
      String? tokenExpired = await PrefUtils.getAssetsTokenExpired();

      return DateTime.parse(tokenExpired);
    } on DioException catch (e) {
      // ignore: avoid_print
      print('get tokenExpired err, $e');
      return DateTime.now();
    }
  }
}
