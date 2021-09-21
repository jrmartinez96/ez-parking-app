import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/core/network/network_info.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_remote_datasource.dart';
import 'package:ez_parking_app/data/datasources/transactions/transactions_remote_datasource.dart';
import 'package:ez_parking_app/data/models/auth/user_session_model.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';
import 'package:ez_parking_app/domain/repositories/transactions_repository.dart';

class TransactionsRepositoryImpl extends TransactionsRepository {
  TransactionsRepositoryImpl({
    required this.remoteDataSource,
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  final TransactionsRemoteDataSource remoteDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, TransactionQuery>> getTransactions() async {
    if (await networkInfo.hasConnection) {
      try {
        final authToken = await authLocalDataSource.getUserToken();
        final transactionsQuery = await remoteDataSource.getTransactions(authToken: authToken);
        return Right(transactionsQuery);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      } on UnauthorizedException {
        try {
          final refreshToken = await authLocalDataSource.getRefreshToken();
          final newAccessToken = await authRemoteDataSource.refreshToken(refreshToken: refreshToken);
          await authLocalDataSource
              .storeUserToken(UserSessionModel(refresh: refreshToken, access: newAccessToken.access));
          return getTransactions();
        } on ServerException {
          return const Left(UnauthorizedFailure());
        }
      }
    } else {
      return Left(internetFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionQuery>> getTransactionsByUrl({required String url}) async {
    if (await networkInfo.hasConnection) {
      try {
        final authToken = await authLocalDataSource.getUserToken();
        final transactionsQuery = await remoteDataSource.getTransactionsByUrl(authToken: authToken, url: url);
        return Right(transactionsQuery);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      } on UnauthorizedException {
        try {
          final refreshToken = await authLocalDataSource.getRefreshToken();
          final newAccessToken = await authRemoteDataSource.refreshToken(refreshToken: refreshToken);
          await authLocalDataSource
              .storeUserToken(UserSessionModel(refresh: refreshToken, access: newAccessToken.access));
          return getTransactionsByUrl(url: url);
        } on ServerException {
          return const Left(UnauthorizedFailure());
        }
      }
    } else {
      return Left(internetFailure());
    }
  }
}
