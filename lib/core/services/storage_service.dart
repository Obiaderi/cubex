import 'dart:convert';

import 'package:cubex/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  /* ====== Token ========= */
  static Future<bool> storeAccessToken(String token) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(StorageKey.accessToken, token);
  }

  static Future<String?> getAccessToken() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(StorageKey.accessToken) &&
        sharedPreferences.getString(StorageKey.accessToken) != null) {
      return sharedPreferences.getString(StorageKey.accessToken);
    }
    return null;
  }

  static Future<bool> storeRefreshToken(String token) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(StorageKey.refreshToken, token);
  }

  static Future<String?> getRefreshToken() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(StorageKey.refreshToken) &&
        sharedPreferences.getString(StorageKey.refreshToken) != null) {
      return sharedPreferences.getString(StorageKey.refreshToken);
    }
    return null;
  }

  /* ====== AuthUser ========= */
  static Future<AuthUser?> getUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(StorageKey.authUser) &&
        sharedPreferences.getString(StorageKey.authUser) != null) {
      return AuthUser.fromJson(
          json.decode(sharedPreferences.getString(StorageKey.authUser)!));
    }
    return null;
  }

  static Future<bool> storeUser(Map<String, dynamic> user) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(StorageKey.authUser, json.encode(user));
  }

  /* ====== Generic ========= */
  // static Future reset() async {
  //   var sharedPreferences = await SharedPreferences.getInstance();
  //   bool? isSeen =
  //       sharedPreferences.getBool(StorageKey.userHasSeenBiometricLoginPrompt);
  //   await sharedPreferences.clear();
  //   await sharedPreferences.remove(StorageKey.accessToken);
  //   await sharedPreferences.remove(StorageKey.refreshToken);

  //   StorageService.storeBoolItem(
  //       StorageKey.userHasSeenBiometricLoginPrompt, isSeen ?? false);
  // }

  static Future logout() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(StorageKey.accessToken);
    await sharedPreferences.remove(StorageKey.refreshToken);
    await sharedPreferences.remove(StorageKey.authUser);
  }

  static storeStringItem(String key, String value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, value);
  }

  static Future<String?> getStringItem(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key) != null) {
      return sharedPreferences.getString(key);
    }
    return null;
  }

  static storeBoolItem(String key, bool value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBoolItem(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getBool(key) != null) {
      return sharedPreferences.getBool(key);
    }
    return null;
  }

  static Future<bool> removeStringItem(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key) != null) {
      return sharedPreferences.remove(key);
    }
    return false;
  }

  static storeString(String key, String value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key) != null) {
      return sharedPreferences.getString(key);
    }
    return null;
  }
}
