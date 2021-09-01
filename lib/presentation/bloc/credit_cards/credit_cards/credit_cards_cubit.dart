import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/get_credit_cards.dart';

part 'credit_cards_state.dart';

class CreditCardsCubit extends Cubit<CreditCardsState> {
  CreditCardsCubit({required this.getCreditCardsUC}) : super(CreditCardsInitial());

  final GetCreditCards getCreditCardsUC;

  Future<void> getCreditCards() async {
    emit(CreditCardsLoading());

    final failureOrCreditCards = await getCreditCardsUC();

    emit(_eitherLoadedOrErrorState(failureOrCreditCards));
  }

  CreditCardsState _eitherLoadedOrErrorState(Either<Failure, List<CreditCard>> failureOrCreditCards) {
    return failureOrCreditCards.fold(
        (failure) => CreditCardsError(message: _mapFailureToMessage(failure), failure: failure),
        (creditCards) => CreditCardsLoaded(creditCards: creditCards));
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
