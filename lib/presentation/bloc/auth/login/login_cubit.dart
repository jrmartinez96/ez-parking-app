import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/user_session.dart';
import 'package:ez_parking_app/domain/use_cases/auth/login_with_email_and_password.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginWithEmailAndPassword}) : super(LoginInitial());

  final LoginWithEmailAndPassword loginWithEmailAndPassword;

  void loginTemp({required String email, required String password}) async {
    emit(LoginLoading());
    final failureOrUserSession = await loginWithEmailAndPassword(email: email, password: password);
    emit(_eitherLoadedOrErrorState(failureOrUserSession));
  }

  void returnToInitial() {
    emit(LoginInitial());
  }

  LoginState _eitherLoadedOrErrorState(Either<Failure, UserSession> failureOrUserSession) {
    return failureOrUserSession.fold(
        (failure) => LoginError(_mapFailureToMessage(failure)), (userSession) => LoginLoaded());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Ha ocurrido un error, por favor intenta nuevamente.';
      default:
        return 'Unexpected error';
    }
  }
}
