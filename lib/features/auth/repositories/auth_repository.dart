import 'package:box_alarm/features/auth/models/info_user_model.dart';

import '../services/auth_service.dart';
import '../models/auth_response_model.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<AuthResponseModel> login(String username, String password) async {
    return await authService.login(username, password);
  }

  Future<InfoUserModel> getInfoUser(String token) async {
    return await authService.getInfoUser(token);
  }

  Future<void> logout(String token) async {
    await authService.logout(token);
  }
}
