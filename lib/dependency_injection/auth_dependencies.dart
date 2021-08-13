import 'package:get_it/get_it.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_remote_datasource.dart';
import 'package:ez_parking_app/data/repositories/auth_repository_impl.dart';
import 'package:ez_parking_app/domain/repositories/auth_repository.dart';
import 'package:ez_parking_app/domain/use_cases/auth/login_with_email_and_password.dart';
import 'package:ez_parking_app/presentation/bloc/auth/login/login_cubit.dart';

/// Inyecta las dependencias relacionadas con las features de autenticación del app.
///
/// ### BLoCs
/// * LoginCubit
///
/// ### Casos de Uso
/// * LoginWithEmailAndPassword
///
/// ### Repositorios
/// * AuthRepository
///
/// ### Datasources
/// * AuthRemoteDataSource
/// * AuthLocalDataSource
void initAuthDependencies(GetIt sl) {
  sl
    // BLoCs
    ..registerFactory(() => LoginCubit(loginWithEmailAndPassword: sl()))
    // use cases
    ..registerLazySingleton(() => LoginWithEmailAndPassword(sl()))
    // Repository
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          remoteDataSource: sl(),
          localDataSource: sl(),
          networkInfo: sl(),
        ))
    // Data sources
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()))
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(secureStorage: sl()));
}
