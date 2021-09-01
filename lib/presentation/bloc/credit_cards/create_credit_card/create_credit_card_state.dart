part of 'create_credit_card_cubit.dart';

abstract class CreateCreditCardState extends Equatable {
  const CreateCreditCardState();

  @override
  List<Object> get props => [];
}

class CreateCreditCardInitial extends CreateCreditCardState {}

class CreateCreditCardLoading extends CreateCreditCardState {}

class CreateCreditCardLoaded extends CreateCreditCardState {
  CreateCreditCardLoaded({required this.creditCard});
  final CreditCard creditCard;
}

class CreateCreditCardError extends CreateCreditCardState {
  CreateCreditCardError({required this.message, required this.failure});

  final String message;
  final Failure failure;
}
