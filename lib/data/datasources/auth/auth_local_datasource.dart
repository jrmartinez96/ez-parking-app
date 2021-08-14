import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/data/models/auth/user_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> storeUserToken(UserSessionModel userSession);
  Future<String> getUserToken();
  Future<void> setOnBoarding();
  int getOnBoarding();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required this.secureStorage, required this.sharedPreferences});

  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  @override
  Future<void> storeUserToken(UserSessionModel userSession) {
    return secureStorage.write(key: 'USER_TOKEN', value: userSession.access);
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

  @override
  Future<void> setOnBoarding() async {
    await sharedPreferences.setInt('onBoarding', 1);
  }

  @override
  int getOnBoarding() {
    return sharedPreferences.getInt('onBoarding') ?? 0;
  }
}
