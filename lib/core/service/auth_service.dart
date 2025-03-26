import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../core/service/pref_utils.dart';
import '../../../shared/constants/shared_constants_export.dart';
import '../../features/auth/views/login_page.dart';
import 'auth_id_token.dart';

typedef AsyncCallBackString = Future<String> Function();
const BUNDLE_IDENTIFIER = "com.oryza.metadata:/oauthredirect";
const AUTH_REDIRECT_URI = "$BUNDLE_IDENTIFIER://login-callback";


class _LoginInfo extends ChangeNotifier {
  var _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

class Auth_Service {
  static final Auth_Service instance = Auth_Service._internal();

  factory Auth_Service() {
    return instance;
  }

  Auth_Service._internal();

  final _loginInfo = _LoginInfo();

  String? accessToken;
  AuthIdToken? authIdToken;
  String? idTokenRaw;

  get logininfo => _loginInfo;

  /// ---------------------------------------
  ///   1 -instantiate appauth
  /// ---------------------------------------

  final appAuth = const FlutterAppAuth();

  /// ---------------------------------------
  ///   2 - init
  /// ---------------------------------------

  Future<String> init() async {
    return errorHandler(() async {
      final securedRefreshToken = await PrefUtils.getRefreshToken();

      final response = await appAuth.token(
        TokenRequest(
          dotenv.get('KEYCLOAK_CLIENT_ID'),
          AUTH_REDIRECT_URI,
          issuer: dotenv.get('KEYCLOAK_ISSUER'),
          refreshToken: securedRefreshToken,
          allowInsecureConnections: false,
        ),
      );

      return await _setLocalVariables(response);
    });
  }

  /// ---------------------------------------
  ///   3 - login
  /// ---------------------------------------

  bool isAuthResultValide(TokenResponse? response) {
    return response?.accessToken != null && response?.idToken != null;
  }

  Future<String> _setLocalVariables(TokenResponse? result) async {
    if (isAuthResultValide(result)) {
      accessToken = result!.accessToken!;
      idTokenRaw = result.idToken!;
      authIdToken = parseIdToken(idTokenRaw!);

      if (result.refreshToken != null) {
        await PrefUtils.setRefreshToken(result.refreshToken!);
        await PrefUtils.setToken(result.accessToken!);
        await PrefUtils.setIdToken(idTokenRaw!);
      }
      log("login success");
      // GoRouter.of(context).go('/feed');
      return 'SUCCESS';
    }
    log("login failed");
    return 'Passing Token went wrong';
  }

  Future<String> errorHandler(AsyncCallBackString callback) async {
    try {
      return callback();
    } on TimeoutException catch (e) {
      return e.message ?? 'Timeout Error!';
    } on FormatException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message ?? 'Something is Wrong!';
    } catch (e) {
      return 'Unknown Error ${e.runtimeType}';
    }
  }

  Future<String> login() async {
    return errorHandler(() async {
      // Create Request
      final authorizationTokenRequest = AuthorizationTokenRequest(
        dotenv.get('KEYCLOAK_CLIENT_ID'),
        AUTH_REDIRECT_URI,
        issuer: dotenv.get('KEYCLOAK_ISSUER'),
        scopes: ['openid', 'profile', 'email', 'offline_access'],
        promptValues: ['login'],
        clientSecret: dotenv.get('KEYCLOAK_CLIENT_SECRET'),
        allowInsecureConnections: false,
      );
      dynamic result;
      try {
        result =
        await appAuth.authorizeAndExchangeCode(authorizationTokenRequest);
        if (result == null) {
          print('Login failed: No result returned.');
          return 'Login failed: No result returned.';
        }

        // Xử lý token và các thông tin nhận được
        print('Login success');
        return await _setLocalVariables(result);
      } catch (err) {
        // Xử lý lỗi khi đăng nhập
        // Kiểm tra nếu lỗi là do người dùng hủy bỏ quá trình đăng nhập
        if (err is FlutterAppAuthUserCancelledException) {
          print('Login cancelled by user');
          return 'Login cancelled by user';
        }
        return 'Login error: $err';
      }
    });
  }

  /// ---------------------------------------
  ///   4 - logout
  /// ---------------------------------------

  logout(String idToken) async {
    try {
      final request = EndSessionRequest(
        idTokenHint: idToken,
        issuer: dotenv.get('KEYCLOAK_ISSUER'),
        postLogoutRedirectUrl: AUTH_REDIRECT_URI,
        allowInsecureConnections: false,
      );

      await appAuth.endSession(request);
      PrefUtils.clearPrefs();
      log('Logout oke');
      // Get.off(() => const LoginPage());
    } catch (e) {
      log('message ,$e');
    }
  }

  /// ---------------------------------------
  ///   5 - parseIdToken
  /// ---------------------------------------

  AuthIdToken parseIdToken(String idToken) {
    final parts = idToken.split(r'.');

    final Map<String, dynamic> json = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    return AuthIdToken.fromJson(json);
  }

  /// ---------------------------------------
  ///   6 - renew token
  /// ---------------------------------------
  bool _isRefreshing = false;
  Completer<TokenResponse?>? _refreshCompleter;

  Future<TokenResponse?> refreshAccessToken() async {
    // Nếu quá trình làm mới đang chạy, đợi kết quả từ quá trình hiện tại
    if (_isRefreshing) {
      return _refreshCompleter?.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<TokenResponse?>();
    try {
      String refreshToken = await PrefUtils.getRefreshToken();

      final TokenResponse result = await appAuth.token(TokenRequest(
        dotenv.get('KEYCLOAK_CLIENT_ID'),
        AUTH_REDIRECT_URI,
        refreshToken: refreshToken,
        clientSecret: dotenv.get('KEYCLOAK_CLIENT_SECRET'),
        discoveryUrl:
        '${dotenv.get('KEYCLOAK_ISSUER')}/.well-known/openid-configuration',
        grantType: 'refresh_token',
      ));

      PrefUtils.setToken(result.accessToken!);
      PrefUtils.setRefreshToken(result.refreshToken!);
      PrefUtils.setAssetsTokenExpired(result.accessTokenExpirationDateTime!);

      accessToken = result.accessToken;
      refreshToken = result.refreshToken!;
      log('Token refreshed');
      return result;
    } catch (e) {
      log('Error: $e');
      // Kiểm tra lỗi "Stale token" và xử lý bằng cách điều hướng người dùng đăng nhập lại
      if (e is PlatformException &&
          e.code == 'token_failed' &&
          e.message?.contains('Stale token') == true) {
        // Điều hướng người dùng đến màn hình đăng nhập
        print('Refresh token has expired. Redirecting to login.');
        await _redirectToLogin();
      } else {
        throw Exception('Failed to refresh token!');
      }
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
    return null;
  }

  Future<void> _redirectToLogin() async {
    // Xóa tất cả thông tin token và chuyển hướng người dùng
    PrefUtils.clearPrefs();
    Get.offAll(() => const LoginPage());
  }
}
