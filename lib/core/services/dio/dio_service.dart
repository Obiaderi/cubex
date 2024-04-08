// ignore_for_file: constant_identifier_names

import 'package:cubex/core/helpers/printty.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHttpMethod {
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String DELETE = 'DELETE';
}

class DioService {
  final Dio _dio = Dio();

  DioService() {
    _dio.options.baseUrl = dotenv.env['BASE_URL'] ?? "";
    _dio.options.connectTimeout = const Duration(milliseconds: 5000); // 5s
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000); // 3s

    // Add an interceptor for handling tokens
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     // Check if the request requires an access token
    //     if (options.headers['Authorization'] == null) {
    //       // Retrieve the access token (e.g., from shared preferences, secure storage, etc.)
    //       String? accessToken = await getAccessToken();
    //       if (accessToken != null) {
    //         options.headers['Authorization'] = 'Bearer $accessToken';
    //       }
    //     }
    //     return handler.next(options); // Continue with the request
    //   },
    //   onError: (DioError e, handler) async {
    //     // Handle token refresh logic here if needed
    //     if (e.response?.statusCode == 401) {
    //       // Attempt to refresh the token
    //       String? newToken = await refreshAccessToken();
    //       if (newToken != null) {
    //         // Retry the request with the new token
    //         RequestOptions requestOptions = e.response!.requestOptions.copyWith(
    //           headers: {
    //             ...e.response!.requestOptions.headers,
    //             'Authorization': 'Bearer $newToken',
    //           },
    //         );
    //         try {
    //           Response response = await _dio.fetch(requestOptions);
    //           return handler.resolve(response);
    //         } on DioError catch (e) {
    //           return handler.next(e);
    //         }
    //       }
    //     }
    //     return handler.next(e); // Continue with the error
    //   },
    // ));
  }

//    Future<String?> getAccessToken() async {
//     // Implement your logic to retrieve the access token
//     // For example, from shared preferences, secure storage, etc.
//     return null; // Placeholder
//  }

//  Future<String?> refreshAccessToken() async {
//     // Implement your logic to refresh the access token
//     // For example, by making a request to your API's token refresh endpoint
//     return null; // Placeholder
//  }

  Future<Response> request(String method, String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      String? accessToken}) async {
    printty(_dio.options.baseUrl, logLevel: 'BASE_URL');
    printty(path, logLevel: 'PATH');
    try {
      if (accessToken != null) {
        _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }
      switch (method) {
        case DioHttpMethod.GET:
          return await _dio.get(path, queryParameters: queryParameters);
        case DioHttpMethod.POST:
          return await _dio.post(path, data: data);
        case DioHttpMethod.PUT:
          return await _dio.put(path, data: data);
        case DioHttpMethod.DELETE:
          return await _dio.delete(path, queryParameters: queryParameters);
        default:
          throw Exception('Invalid HTTP method');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('Username already exists');
      }
      _handleDioError(e);
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      printty("Timeout error occurred");
    } else if (e.type == DioExceptionType.sendTimeout) {
      printty("Send timeout error occurred");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      printty("Receive timeout error occurred");
    } else if (e.type == DioExceptionType.badResponse) {
      printty(
          "Response error occurred ${e.response?.statusCode} ${e..message}");
    } else if (e.type == DioExceptionType.cancel) {
      printty("Request cancelled");
    } else {
      printty("An error occurred: ${e.message}");
    }
  }
}
