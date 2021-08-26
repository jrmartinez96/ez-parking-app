part of 'edit_credit_card_cubit.dart';

abstract class EditCreditCardState extends Equatable {
  const EditCreditCardState();

  @override
  List<Object> get props => [];
}

class EditCreditCardInitial extends EditCreditCardState {}

class EditCreditCardLoadingUpdate extends EditCreditCardState {}

class EditCreditCardLoadingDelete extends EditCreditCardState {}

class EditCreditCardLoadedUpdate extends EditCreditCardState {
  EditCreditCardLoadedUpdate({required this.creditCard});
  final CreditCard creditCard;
}

class EditCreditCardLoadedDelete extends EditCreditCardState {
  EditCreditCardLoadedDelete({required this.creditCard});
  final CreditCard creditCard;
}

class EditCreditCardError extends EditCreditCardState {
  EditCreditCardError({required this.message, required this.failure});

  final String message;
  final Failure failure;
}
