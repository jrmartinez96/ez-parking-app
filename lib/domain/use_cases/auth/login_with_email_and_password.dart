import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/user_session.dart';
import 'package:ez_parking_app/domain/repositories/auth_repository.dart';

class LoginWithEmailAndPassword {
  LoginWithEmailAndPassword(this.authRepository);

  final AuthRepository authRepository;

  Future<Either<Failure, UserSession>> call({
    required String email,
    required String password,
  }) async {
    return authRepository.logInWithEmailAndPassword(email: email, password: password);
  }
}
