import 'package:ez_parking_app/data/datasources/transactions/transactions_remote_datasource.dart';
import 'package:ez_parking_app/data/repositories/transactions_repository_impl.dart';
import 'package:ez_parking_app/domain/repositories/transactions_repository.dart';
import 'package:ez_parking_app/domain/use_cases/transactions/enter_or_exit_mall.dart';
import 'package:ez_parking_app/domain/use_cases/transactions/get_transactions.dart';
import 'package:ez_parking_app/presentation/bloc/transactions/transactions/transactions_cubit.dart';
import 'package:get_it/get_it.dart';

/// Inyecta las dependencias relacionadas con las features de autenticación del app.
///
/// ### BLoCs
/// * TransactionsCubit
///
/// ### Casos de Uso
/// * GetTransactions
/// * EnterOrExitMall
///
/// ### Repositorios
/// * TransactionsRepository
///
/// ### Datasources
/// * TransactionsRemoteDataSource
void initTransactionsDependencies(GetIt sl) {
  sl
    // BLoCs
    ..registerFactory(() => TransactionsCubit(getTransactionsUC: sl()))
    // use cases
    ..registerLazySingleton(() => GetTransactions(sl()))
    ..registerLazySingleton(() => EnterOrExitMall(sl()))
    // Repository
    ..registerLazySingleton<TransactionsRepository>(() => TransactionsRepositoryImpl(
          remoteDataSource: sl(),
          authLocalDataSource: sl(),
          authRemoteDataSource: sl(),
          networkInfo: sl(),
        ))
    // Data sources
    ..registerLazySingleton<TransactionsRemoteDataSource>(() => TransactionsRemoteDataSourceImpl(client: sl()));
}
