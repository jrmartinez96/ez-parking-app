import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/reset_password_response.dart';
import 'package:ez_parking_app/domain/repositories/auth_repository.dart';

class ResetPassword {
  ResetPassword(this.authRepository);

  final AuthRepository authRepository;

  Future<Either<Failure, ResetPasswordResponse>> call({required String email}) async {
    return authRepository.resetPassword(email: email);
  }
}
