part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordLoaded extends ResetPasswordState {}

class ResetPasswordError extends ResetPasswordState {
  ResetPasswordError({required this.message, required this.failure});

  final String message;
  final Failure failure;
}
