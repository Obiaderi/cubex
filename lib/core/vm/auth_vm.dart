import 'dart:convert';

import 'package:cubex/core/core.dart';

class AuthVM extends BaseVM {
  TextEditingController userNameC = TextEditingController(text: 'lorem');
  TextEditingController passwordC = TextEditingController(text: 'password');

  AuthUser? _authUser;
  AuthUser? get authUser => _authUser;

  btnIsValid() {
    return userNameC.text.trim().isNotEmpty && passwordC.text.trim().isNotEmpty;
  }

  Future<ApiResponse> login() async {
    return makeRequest(
      method: DioHttpMethod.POST,
      endpoint: '/login',
      data: {
        "username": userNameC.text.trim(),
        "password": passwordC.text.trim(),
      },
      onSuccess: (data) {
        StorageService.storeAccessToken(data['token']);
        return ApiResponse(success: true, data: data);
      },
    );
  }

  Future<ApiResponse> getProfile() async {
    return makeRequest(
      method: DioHttpMethod.GET,
      accessToken: await StorageService.getAccessToken(),
      endpoint: '/profile',
      onSuccess: (data) {
        printty(data);
        _authUser = authUserFromJson(json.encode(data));
        return ApiResponse(success: true, data: data);
      },
    );
  }

  logOut() async {
    try {
      await StorageService.logout();
    } catch (e) {
      printty(e);
    }
  }
}
