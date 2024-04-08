import 'dart:async';

import 'package:cubex/core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioApiService {
  int timeOutDurationInSeconds = 30;
  int connectionTimeout = 6000;
  AppInterceptors appInterceptors;
  late Dio dio;

  var options = BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? "",
    connectTimeout: const Duration(seconds: 6000),
    receiveTimeout: const Duration(seconds: 3000),
  );

  DioApiService({required this.appInterceptors}) {
    dio = Dio(options);
    dio.interceptors.add(appInterceptors);
    Map<String, dynamic> headers = {'Accept': 'application/json'};
    dio.options.headers = headers;
  }

  Future<ApiResponse> post({dynamic body, required var url}) async {
    try {
      printty(dio.options.baseUrl);
      printty(url);
      printty(options.headers.toString());
      printty("headers===>");
      Response response = await Dio(options)
          .post(url, data: FormData.fromMap(body))
          .timeout(Duration(seconds: timeOutDurationInSeconds));
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      printty("error");
      return DioResponseHandler.dioErrorHandler(e);
    }
  }

  Future<ApiResponse> get({required String url}) async {
    try {
      var options = BaseOptions();
      Response response = await Dio(options)
          .get(url)
          .timeout(Duration(seconds: timeOutDurationInSeconds));
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    }
  }

  Future<ApiResponse> put(
      {required Map<String, dynamic> body, required var url}) async {
    try {
      var options = BaseOptions();
      Response response = await Dio(options)
          .put(url, data: FormData.fromMap(body))
          .timeout(Duration(seconds: timeOutDurationInSeconds));
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    }
  }

  Future<ApiResponse> postWithAuth(
      {var body,
      required var url,
      bool canRetry = true,
      String? contentType}) async {
    try {
      if (contentType != null) {
        dio.options.contentType = contentType;
      }

      dynamic data = body;
      if (body != null) {
        data = FormData.fromMap(body);
      }

      Response response = await dio
          .post(url, data: contentType == null ? data : body)
          .timeout(Duration(seconds: timeOutDurationInSeconds));
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e, s) {
      printty(e.toString());
      printty(s.toString());
      return DioResponseHandler.dioErrorHandler(e);
    } catch (e) {
      printty("flsjfklskf: $e");
      return ApiResponse(success: false);
    }
  }

  Future<ApiResponse> deleteWithAuth(
      {var body,
      required var url,
      bool canRetry = true,
      String? contentType}) async {
    try {
      if (contentType != null) {
        dio.options.contentType = contentType;
      }

      dynamic data = body;
      if (body != null) {
        data = FormData.fromMap(body);
      }

      Response response = await dio
          .delete(url, data: contentType == null ? data : body)
          .timeout(Duration(seconds: timeOutDurationInSeconds));
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e, s) {
      printty(e.toString());
      printty(s.toString());
      return DioResponseHandler.dioErrorHandler(e);
    } catch (e) {
      printty("flsjfklskf: $e");
      return ApiResponse(success: false);
    }
  }

  Future<ApiResponse> getWithAuth(
      {var body, required var url, bool canRetry = true}) async {
    try {
      Response response = await dio
          .get(url)
          .timeout(Duration(seconds: timeOutDurationInSeconds));
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    }
  }

  Future<ApiResponse> printtyout() async {
    await StorageService.logout();
    return ApiResponse(
        code: 401, success: false, message: "Unauthorized. Access denied!!!");
  }
}

DioApiService apiService = DioApiService(appInterceptors: AppInterceptors());
