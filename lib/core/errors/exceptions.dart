class AppException implements Exception {
  AppException({
    required this.message,
    required this.code,
  });

  @override
  String toString() {
    return '$code: $message';
  }

  // ignore: prefer_typing_uninitialized_variables
  final int code;
  // ignore: prefer_typing_uninitialized_variables
  final String message;
}

class ServerException extends AppException {
  ServerException([
    String message = '',
    int code = 1,
  ]) : super(message: message, code: code);

  @override
  String get message;
  @override
  int get code;
}

class CacheException implements Exception {}

class UnauthorizedException extends AppException {
  UnauthorizedException([
    String message = 'Tu token ha expirado',
    int code = 401,
  ]) : super(message: message, code: code);
}
