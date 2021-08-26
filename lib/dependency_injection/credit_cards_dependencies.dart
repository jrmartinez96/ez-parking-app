import 'package:ez_parking_app/data/datasources/credit_cards/credit_cards_remote_datasource.dart';
import 'package:ez_parking_app/data/repositories/credit_cards_repository_impl.dart';
import 'package:ez_parking_app/domain/repositories/credit_cards_repository.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/create_credit_card.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/delete_credit_card_by_id.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/get_credit_card_by_id.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/get_credit_cards.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/update_credit_card_by_id.dart';
import 'package:get_it/get_it.dart';

/// Inyecta las dependencias relacionadas con las features de autenticación del app.
///
/// ### BLoCs
/// *
///
/// ### Casos de Uso
/// * CreateCreditCard
/// * DeleteCreditCardById
/// * GetCreditCardById
/// * GetCreditCards
/// * UpdateCreditCardById
///
/// ### Repositorios
/// * CreditCardsRepository
///
/// ### Datasources
/// * CreditCardsRemoteDataSource
void initCreditCardsDependencies(GetIt sl) {
  sl
    // BLoCs
    // use cases
    ..registerLazySingleton(() => CreateCreditCard(sl()))
    ..registerLazySingleton(() => DeleteCreditCardById(sl()))
    ..registerLazySingleton(() => GetCreditCardById(sl()))
    ..registerLazySingleton(() => GetCreditCards(sl()))
    ..registerLazySingleton(() => UpdateCreditCardById(sl()))
    // Repository
    ..registerLazySingleton<CreditCardsRepository>(() => CreditCardsRepositoryImpl(
          remoteDataSource: sl(),
          authLocalDataSource: sl(),
          networkInfo: sl(),
        ))
    // Data sources
    ..registerLazySingleton<CreditCardsRemoteDataSource>(() => CreditCardsRemoteDataSourceImpl(client: sl()));
}
