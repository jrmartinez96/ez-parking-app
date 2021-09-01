part of 'credit_cards_cubit.dart';

abstract class CreditCardsState extends Equatable {
  const CreditCardsState();

  @override
  List<Object> get props => [];
}

class CreditCardsInitial extends CreditCardsState {}

class CreditCardsLoading extends CreditCardsState {}

class CreditCardsLoaded extends CreditCardsState {
  CreditCardsLoaded({required this.creditCards});

  final List<CreditCard> creditCards;
}

class CreditCardsError extends CreditCardsState {
  CreditCardsError({required this.message, required this.failure});

  final String message;
  final Failure failure;
}
