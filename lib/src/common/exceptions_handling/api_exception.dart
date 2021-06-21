class ApiException implements Exception {
  final String? message;
  final int? code;
  ApiException({
    this.code,
    this.message,
  });
}
