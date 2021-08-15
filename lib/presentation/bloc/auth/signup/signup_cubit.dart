import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/auth/signup_success.dart';
import 'package:ez_parking_app/domain/use_cases/auth/signup.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.signup}) : super(SignupInitial());

  final Signup signup;

  Future<void> signupUser({
    required String email,
    required String name,
    required String lastname,
    required String password,
  }) async {
    emit(SignupLoading());
    final response = await signup(email: email, name: name, lastname: lastname, password: password);
    emit(_eitherLoadedOrErrorState(response));
  }

  SignupState _eitherLoadedOrErrorState(Either<Failure, SignupSuccess> failureOrSignupSuccess) {
    return failureOrSignupSuccess.fold(
        (failure) => SignupError(message: _mapFailureToMessage(failure), failure: failure),
        (signupSuccess) => SignupLoaded(signupSuccess: signupSuccess));
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
