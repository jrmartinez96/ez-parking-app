import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ez_parking_app/core/network/network_info.dart';

import 'auth_dependencies.dart';

/// Instancia del service locator para acceder a GetIt
final sl = GetIt.instance;

/// Inicializa la inyeccion de dependencias para el app en general.
Future<void> init() async {
  initAuthDependencies(sl);

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  // ignore: cascade_invocations
  sl
    ..registerLazySingleton(() => http.Client())
    ..registerLazySingleton(() => InternetConnectionChecker())
    ..registerLazySingleton(() => const FlutterSecureStorage());
}
