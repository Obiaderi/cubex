import 'package:cubex/core/core.dart';

class BaseVM extends ChangeNotifier {
  final dioService = DioService();

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  bool _hasError = false;
  bool get hasError => _hasError;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  Future<ApiResponse> makeRequest({
    required String method,
    required String endpoint,
    String? accessToken,
    Map<String, dynamic>? data,
    required ApiResponse Function(dynamic) onSuccess,
  }) async {
    try {
      setBusy(true);
      final response = await dioService.request(
        method,
        endpoint,
        data: data,
        accessToken: accessToken,
      );
      setBusy(false);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        printty(response.data, logLevel: endpoint);
        return onSuccess(response.data);
      } else {
        setError(true);
        printty('An error else: ${response.data}', logLevel: endpoint);
        return ApiResponse(success: false, data: response.data);
      }
    } catch (e) {
      setError(true);
      setBusy(false);
      printty('An error catch: $e', logLevel: endpoint);
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
