import 'dart:convert';

import 'package:cubex/core/core.dart';

class AuthVM extends BaseVM {
  TextEditingController userNameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  AuthUser? _authUser;
  AuthUser? get authUser => _authUser;

  String? _passCode;
  String? get passCode => _passCode;

  setPassCode(String passCode) {
    _passCode = passCode;
    notifyListeners();
  }

  bool get isAuthenticate => _passCode == '1234';

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
        StorageService.storeUser(data);
        return ApiResponse(success: true, data: data);
      },
    );
  }

  getUserFromStorage() async {
    var user = await StorageService.getUser();
    if (user != null) {
      _authUser = authUserFromJson(json.encode(user));
      notifyListeners();
    }
  }

  logOut() async {
    try {
      await StorageService.logout();
    } catch (e) {
      printty(e);
    }
  }
}
