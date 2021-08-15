part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupLoaded extends SignupState {
  SignupLoaded({required this.signupSuccess});

  final SignupSuccess signupSuccess;
}

class SignupError extends SignupState {
  const SignupError({required this.message, required this.failure});

  final String message;
  final Failure failure;

  @override
  List<Object> get props => [message];
}
