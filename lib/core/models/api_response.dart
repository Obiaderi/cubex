class ApiResponse<T> {
  bool success;
  T? data;
  String? message;
  int? code;

  ApiResponse({required this.success, this.data, this.message, this.code});
}
