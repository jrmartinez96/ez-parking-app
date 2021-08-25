// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/reset_password_response.dart';
import 'package:ez_parking_app/domain/entities/auth/signup_success.dart';
import 'package:ez_parking_app/domain/entities/auth/user_session.dart';

abstract class AuthRepository {
  // Setea el valor de onBoarding
  Future<void> setOnBoading();
  // Regresa el valor de onBoarding
  int getOnBoading();
  // Realiza un login con correo electronico y password
  Future<Either<Failure, UserSession>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  // Realiza el registro de un usuario
  Future<Either<Failure, SignupSuccess>> signup({
    required String email,
    required String name,
    required String lastname,
    required String password,
  });
  // Solicita un correo para poder reiniciar la contraseña
  Future<Either<Failure, ResetPasswordResponse>> resetPassword({required String email});
}
