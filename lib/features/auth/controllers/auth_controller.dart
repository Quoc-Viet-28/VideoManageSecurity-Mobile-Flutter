import 'dart:convert';
import 'package:box_alarm/features/auth/models/info_user_model.dart';
import 'package:box_alarm/shared/constants/app_logger.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/network/token_manager.dart';
import '../models/payload.dart';
import '../repositories/auth_repository.dart';
import '../models/auth_response_model.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  var isAdmin = false.obs;
  var isLoading = false.obs;
  var authResponse = AuthResponseModel().obs;
  var payload = PayLoad().obs;
  var infoUser = InfoUserModel().obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      authResponse.value = await authRepository.login(username, password);
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(authResponse.value.accessToken!);
      payload.value = PayLoad.fromJson(decodedToken);

      if (authResponse.value.accessToken == null) {
        throw Exception('Đăng nhập không thành công');
      }
    } catch (e) {
      print('Đăng nhập không thành công: ${e.toString()}');
      throw Exception('Đăng nhập không thành công: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getInfoUser() async {
    isLoading.value = true;
    try {
      infoUser.value =
          await authRepository.getInfoUser(authResponse.value.accessToken!);
    } catch (e) {
      throw Exception(
          'Lấy thông tin người dùng không thành công: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      if (authResponse.value.accessToken != null) {
        await authRepository.logout(authResponse.value.accessToken!);
      } else {
        throw Exception('Không tìm thấy access token để logout.');
      }

      // Reset
      authResponse.value = AuthResponseModel();
      payload.value = PayLoad();
      infoUser.value = InfoUserModel();

      // Xóa token khỏi token manager
      await TokenManager.removeToken();
    } catch (e) {
      // Xử lý lỗi khi logout thất bại
      throw Exception('Logout thất bại: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
