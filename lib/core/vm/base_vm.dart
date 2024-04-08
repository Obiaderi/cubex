import 'package:cubex/core/core.dart';

class BaseVM extends ChangeNotifier {
  late ApiResponse apiResponse;

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

  reset() {}

  Future<ApiResponse> performApiCall({
    required String url,
    required Future<ApiResponse> Function(
            {dynamic body, bool canRetry, required dynamic url})
        method,
    Map<String, dynamic>? body,
    required ApiResponse Function(Map<String, dynamic> data) onSuccess,
    ApiResponse Function(String errorMessage)? onError,
  }) async {
    try {
      setBusy(true);
      apiResponse = await method(
          url: url,
          body: body,
          canRetry: true); // Assuming canRetry is always true for simplicity

      if (!apiResponse.success) {
        setBusy(false);
        printty(apiResponse.message, logLevel: url.toString());
        return apiResponse;
      }

      printty(apiResponse.data, logLevel: url.toString());
      return onSuccess(apiResponse.data);
    } catch (e, s) {
      printty(e, logLevel: url.toString());
      printty(s.toString());
      setError(true);
      if (onError != null) {
        return onError(e.toString());
      } else {
        // Default error handling
        return ApiResponse(success: false, message: e.toString());
      }
    } finally {
      setBusy(false);
    }
  }
}
