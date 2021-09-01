import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/delete_credit_card_by_id.dart';
import 'package:ez_parking_app/domain/use_cases/credit_cards/update_credit_card_by_id.dart';

part 'edit_credit_card_state.dart';

class EditCreditCardCubit extends Cubit<EditCreditCardState> {
  EditCreditCardCubit({
    required this.updateCreditCardById,
    required this.deleteCreditCardById,
  }) : super(EditCreditCardInitial());

  final UpdateCreditCardById updateCreditCardById;
  final DeleteCreditCardById deleteCreditCardById;

  Future<void> updateCreditCard({
    required int id,
    required String cardNumber,
    required String holder,
    required String expirationDate,
  }) async {
    emit(EditCreditCardLoadingUpdate());

    final failureOrCreditCard = await updateCreditCardById(
      id: id,
      cardNumber: cardNumber,
      holder: holder,
      expirationDate: expirationDate,
    );

    emit(_eitherLoadedUpdateOrErrorState(failureOrCreditCard));
  }

  Future<void> deleteCreditCard({
    required int id,
  }) async {
    emit(EditCreditCardLoadingDelete());

    final failureOrCreditCard = await deleteCreditCardById(id: id);

    emit(_eitherLoadedDeleteOrErrorState(failureOrCreditCard));
  }

  EditCreditCardState _eitherLoadedUpdateOrErrorState(Either<Failure, CreditCard> failureOrCreditCard) {
    return failureOrCreditCard.fold(
        (failure) => EditCreditCardError(message: _mapFailureToMessage(failure), failure: failure),
        (creditCard) => EditCreditCardLoadedUpdate(creditCard: creditCard));
  }

  EditCreditCardState _eitherLoadedDeleteOrErrorState(Either<Failure, CreditCard> failureOrCreditCard) {
    return failureOrCreditCard.fold(
        (failure) => EditCreditCardError(message: _mapFailureToMessage(failure), failure: failure),
        (creditCard) => EditCreditCardLoadedDelete(creditCard: creditCard));
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
