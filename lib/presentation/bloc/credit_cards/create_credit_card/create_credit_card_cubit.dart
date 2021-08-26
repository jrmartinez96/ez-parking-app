import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/create_credit_card.dart';

part 'create_credit_card_state.dart';

class CreateCreditCardCubit extends Cubit<CreateCreditCardState> {
  CreateCreditCardCubit({required this.createCreditCardUC}) : super(CreateCreditCardInitial());

  final CreateCreditCard createCreditCardUC;

  Future<void> createCreditCard({
    required String cardNumber,
    required String holder,
    required String expirationDate,
  }) async {
    emit(CreateCreditCardLoading());

    final failureOrCreditCard = await createCreditCardUC(
      cardNumber: cardNumber,
      holder: holder,
      expirationDate: expirationDate,
    );

    emit(_eitherLoadedOrErrorState(failureOrCreditCard));
  }

  CreateCreditCardState _eitherLoadedOrErrorState(Either<Failure, CreditCard> failureOrCreditCard) {
    return failureOrCreditCard.fold(
        (failure) => CreateCreditCardError(message: _mapFailureToMessage(failure), failure: failure),
        (creditCard) => CreateCreditCardLoaded(creditCard: creditCard));
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
