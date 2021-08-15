import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/signup_success.dart';
import 'package:ez_parking_app/domain/repositories/auth_repository.dart';

class Signup {
  Signup(this.authRepository);

  final AuthRepository authRepository;

  Future<Either<Failure, SignupSuccess>> call({
    required String email,
    required String name,
    required String lastname,
    required String password,
  }) async {
    return authRepository.signup(email: email, name: name, lastname: lastname, password: password);
  }
}
