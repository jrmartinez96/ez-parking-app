// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/user_session.dart';

abstract class AuthRepository {
  // Realiza un login con correo electronico y password
  Future<Either<Failure, UserSession>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
