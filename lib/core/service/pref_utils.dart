// import 'package:flutter_mobile/core/services/prefs/pref_keys.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'pref_keys.dart';

class PrefUtils {
  PrefUtils();

  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PrefKeys.assetsToken, token);
  }

  static setRefreshToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PrefKeys.refreshToken, token);
  }

  static setAssetsTokenExpired(DateTime token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PrefKeys.assetsTokenExpired, token.toString());
  }

  static setRefreshTokenExpired(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PrefKeys.refreshTokenExpired, token);
  }

  static setIdToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PrefKeys.idToken, token);
  }

  static getIdToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(PrefKeys.idToken);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(PrefKeys.assetsToken) ?? "";
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(PrefKeys.refreshToken) ?? "";
  }

  static Future<String> getAssetsTokenExpired() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(PrefKeys.assetsTokenExpired) ?? "";
  }

  static Future<String> getRefreshTokenExpired() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(PrefKeys.refreshTokenExpired) ?? "";
  }

  static clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
