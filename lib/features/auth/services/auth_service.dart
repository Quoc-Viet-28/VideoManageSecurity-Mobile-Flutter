import 'package:box_alarm/features/auth/models/info_user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/network/api_service.dart';
import '../models/auth_response_model.dart';

class AuthService {
  final String baseUrl = '$urlApiLogin/protocol/openid-connect/token';
  final secret = 'wbytNC33SGy68CnsZyiIOXxsSUJpo5vw';

  Future<AuthResponseModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': username,
        'password': password,
        'grant_type': 'password',
        'client_id': 'box-alarm',
        'client_secret': secret,
      },
    );

    // print(response.body);
    // print(response.statusCode);



    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Đăng nhập không thành công: ${response.reasonPhrase}');
    }
  }

  Future<InfoUserModel> getInfoUser(String token) async {
    final response = await http.get(
      Uri.parse('$urlApi/user/get-info'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Sử dụng utf8.decode để giải mã body
      String decodedBody = utf8.decode(response.bodyBytes);
      return InfoUserModel.fromJson(json.decode(decodedBody));
    } else {
      throw Exception(
          'Lấy thông tin người dùng không thành công: ${response.reasonPhrase}');
    }
  }

  Future<void> logout(String token) async {}
}
