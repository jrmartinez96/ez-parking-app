import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/core/network/network_info.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_local_datasource.dart';
import 'package:ez_parking_app/data/datasources/auth/auth_remote_datasource.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/user_session.dart';
import 'package:ez_parking_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, UserSession>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    if (await networkInfo.hasConnection) {
      try {
        final userSession = await remoteDataSource.loginWithEmailAndPassword(email: email, password: password);
        await localDataSource.storeUserToken(userSession);
        return Right(userSession);
      } on ServerException catch (serverException) {
        return Left(ServerFailure(code: serverException.code, message: serverException.message));
      }
    } else {
      return Left(internetFailure());
    }
  }
}
