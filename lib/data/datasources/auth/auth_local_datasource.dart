import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/data/models/auth/user_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> storeUserToken(UserSessionModel userSession);
  Future<String> getUserToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> storeUserToken(UserSessionModel userSession) {
    return secureStorage.write(key: 'USER_TOKEN', value: userSession.accesToken);
  }

  @override
  Future<String> getUserToken() async {
    final token = await secureStorage.read(key: 'USER_TOKEN');
    if (token != null) {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }
}
