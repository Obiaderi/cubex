import 'dart:async';
import 'dart:developer';

import 'package:cubex/core/core.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends QueuedInterceptorsWrapper {
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();
  bool isTrustedDevice = true;

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await StorageService.getString(StorageKey.accessToken);
    // printty("base url:===> ${options.baseUrl}");
    // printty("url path:===> ${options.path}");

    // printty("url headers:===> ${options.headers.toString()}");
    // printty(token.toString());

    if (token == null) {
      handler.reject(DioException(requestOptions: options));
      logout();
      return;
    }
    options.headers.addAll({"authorization": "Bearer $token"});
    handler.next(options);
    //return super.onRequest(options, handler);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    ApiResponse res = DioResponseHandler.dioErrorHandler(err);

    if (res.code == 401 || res.code == 403) {
      logout();
      return;
    }

    if (res.code == 500 &&
        res.message != null &&
        res.message!
            .contains("This device is not set as your trusted device.")) {
      ApiResponse res = DioResponseHandler.dioErrorHandler(err);
      log("ssss: ${res.message}");
      final dioError = DioException(
          message: res.message,
          type: DioExceptionType.badResponse,
          requestOptions: err.requestOptions,
          response: Response(
              statusCode: 409,
              requestOptions: err.requestOptions,
              data: {
                "success": false,
                "message": res.message ??
                    "This device is not set as your trusted device"
              },
              statusMessage: res.message ??
                  "This device is not set as your trusted device"));
      return handler.reject(dioError);
    }

    return handler.next(err);
  }

  Future<void> logout() async {
    await StorageService.logout();
    gotoNextScreen(RoutePath.loginScreen);
  }

  gotoNextScreen(String route) {
    Navigator.pushNamedAndRemoveUntil(
        NavigatorKeys.appNavigatorKey.currentContext!, route, (r) => false);
  }
}
