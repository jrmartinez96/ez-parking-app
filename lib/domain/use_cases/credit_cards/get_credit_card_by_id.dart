import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';
import 'package:ez_parking_app/domain/repositories/credit_cards_repository.dart';

class GetCreditCardById {
  GetCreditCardById(this.creditCardsRepository);

  final CreditCardsRepository creditCardsRepository;

  Future<Either<Failure, CreditCard>> call({required int id}) async {
    return creditCardsRepository.getCreditCardById(id: id);
  }
}
