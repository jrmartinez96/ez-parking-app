import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/core/network/network_info.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_remote_datasource.dart';
import 'package:ez_parking_app/data/datasources/credit_cards/credit_cards_remote_datasource.dart';
import 'package:ez_parking_app/data/models/auth/user_session_model.dart';
import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';
import 'package:ez_parking_app/domain/repositories/credit_cards_repository.dart';

class CreditCardsRepositoryImpl extends CreditCardsRepository {
  CreditCardsRepositoryImpl({
    required this.remoteDataSource,
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  final CreditCardsRemoteDataSource remoteDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, CreditCard>> createCreditCard({
    required String cardNumber,
    required String holder,
    required String expirationDate,
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        final authToken = await authLocalDataSource.getUserToken();
        final creditCard = await remoteDataSource.createCreditCard(
          authToken: authToken,
          cardNumber: cardNumber,
          holder: holder,
          expirationDate: expirationDate,
        );
        return Right(creditCard);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      } on UnauthorizedException {
        try {
          final refreshToken = await authLocalDataSource.getRefreshToken();
          final newAccessToken = await authRemoteDataSource.refreshToken(refreshToken: refreshToken);
          await authLocalDataSource
              .storeUserToken(UserSessionModel(refresh: refreshToken, access: newAccessToken.access));
          return createCreditCard(cardNumber: cardNumber, holder: holder, expirationDate: expirationDate);
        } on ServerException {
          return const Left(UnauthorizedFailure());
        }
      }
    } else {
      return Left(internetFailure());
    }
  }

  @override
  Future<Either<Failure, CreditCard>> deleteCreditCardById({required int id}) async {
    if (await networkInfo.hasConnection) {
      try {
        final authToken = await authLocalDataSource.getUserToken();
        final creditCard = await remoteDataSource.deleteCreditCardById(authToken: authToken, id: id);
        return Right(creditCard);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      } on UnauthorizedException {
        try {
          final refreshToken = await authLocalDataSource.getRefreshToken();
          final newAccessToken = await authRemoteDataSource.refreshToken(refreshToken: refreshToken);
          await authLocalDataSource
              .storeUserToken(UserSessionModel(refresh: refreshToken, access: newAccessToken.access));
          return deleteCreditCardById(id: id);
        } on ServerException {
          return const Left(UnauthorizedFailure());
        }
      }
    } else {
      return Left(internetFailure());
    }
  }

  @override
  Future<Either<Failure, CreditCard>> getCreditCardById({required int id}) async {
    if (await networkInfo.hasConnection) {
      try {
        final authToken = await authLocalDataSource.getUserToken();
        final creditCard = await remoteDataSource.getCreditCardById(authToken: authToken, id: id);
        return Right(creditCard);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      } on UnauthorizedException {
        try {
          final refreshToken = await authLocalDataSource.getRefreshToken();
          final newAccessToken = await authRemoteDataSource.refreshToken(refreshToken: refreshToken);
          await authLocalDataSource
              .storeUserToken(UserSessionModel(refresh: refreshToken, access: newAccessToken.access));
          return getCreditCardById(id: id);
        } on ServerException {
          return const Left(UnauthorizedFailure());
        }
      }
    } else {
      return Left(internetFailure());
    }
  }

  @override
  Future<Either<Failure, List<CreditCard>>> getCreditCards() async {
    if (await networkInfo.hasConnection) {
      try {
        final authToken = await authLocalDataSource.getUserToken();
        final creditCards = await remoteDataSource.getCreditCards(authToken: authToken);
        return Right(creditCards);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      } on UnauthorizedException {
        try {
          final refreshToken = await authLocalDataSource.getRefreshToken();
          final newAccessToken = await authRemoteDataSource.refreshToken(refreshToken: refreshToken);
          await authLocalDataSource
              .storeUserToken(UserSessionModel(refresh: refreshToken, access: newAccessToken.access));
          return getCreditCards();
        } on ServerException {
          return const Left(UnauthorizedFailure());
        }
      }
    } else {
      return Left(internetFailure());
    }
  }

  @override
  Future<Either<Failure, CreditCard>> updateCreditCardById(
      {required String cardNumber, required String holder, required String expirationDate, required int id}) async {
    if (await networkInfo.hasConnection) {
      try {
        final authToken = await authLocalDataSource.getUserToken();
        final creditCard = await remoteDataSource.updateCreditCardById(
          authToken: authToken,
          cardNumber: cardNumber,
          holder: holder,
          expirationDate: expirationDate,
          id: id,
        );
        return Right(creditCard);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      } on UnauthorizedException {
        try {
          final refreshToken = await authLocalDataSource.getRefreshToken();
          final newAccessToken = await authRemoteDataSource.refreshToken(refreshToken: refreshToken);
          await authLocalDataSource
              .storeUserToken(UserSessionModel(refresh: refreshToken, access: newAccessToken.access));
          return updateCreditCardById(cardNumber: cardNumber, holder: holder, expirationDate: expirationDate, id: id);
        } on ServerException {
          return const Left(UnauthorizedFailure());
        }
      }
    } else {
      return Left(internetFailure());
    }
  }
}
