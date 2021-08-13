class AppException implements Exception {
  AppException([
    this._message,
    this._code,
  ]);

  @override
  String toString() {
    return '$_code: $_message';
  }

  // ignore: prefer_typing_uninitialized_variables
  final _code;
  // ignore: prefer_typing_uninitialized_variables
  final _message;
}

class ServerException extends AppException {
  ServerException([
    String message = '',
    int code = 1,
  ]) : super(message, code);

  String get message => _message;
  int get code => _code;
}

class CacheException implements Exception {}

class UnauthorizedException extends AppException {
  UnauthorizedException([
    String message = 'Tu token ha expirado',
    int code = 401,
  ]) : super(message, code);
}
