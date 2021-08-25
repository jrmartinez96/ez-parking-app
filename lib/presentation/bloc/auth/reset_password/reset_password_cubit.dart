import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/reset_password_response.dart';
import 'package:ez_parking_app/domain/use_cases/auth/reset_password.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({required this.resetPasswordUC}) : super(ResetPasswordInitial());

  final ResetPassword resetPasswordUC;

  Future<void> resetPassword({required String email}) async {
    emit(ResetPasswordLoading());

    final failureOrResetPassword = await resetPasswordUC(email: email);

    emit(_eitherLoadedOrErrorState(failureOrResetPassword));
  }

  ResetPasswordState _eitherLoadedOrErrorState(Either<Failure, ResetPasswordResponse> failureOrResetPassword) {
    return failureOrResetPassword.fold(
        (failure) => ResetPasswordError(message: _mapFailureToMessage(failure), failure: failure),
        (signupSuccess) => ResetPasswordLoaded());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message;
      default:
        return 'Unexpected error';
    }
  }
}
