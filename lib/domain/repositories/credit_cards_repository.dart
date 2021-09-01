import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';

abstract class CreditCardsRepository {
  // Solicita el listado de tarjetas de credito del usuario
  Future<Either<Failure, List<CreditCard>>> getCreditCards();
  // Crea una tarjeta de credito
  Future<Either<Failure, CreditCard>> createCreditCard({
    required String cardNumber,
    required String holder,
    required String expirationDate,
  });
  // Solicita una tarjeta de credito por ID
  Future<Either<Failure, CreditCard>> getCreditCardById({required int id});
  // Actualiza la informacion de una tarjeta de credito
  Future<Either<Failure, CreditCard>> updateCreditCardById({
    required String cardNumber,
    required String holder,
    required String expirationDate,
    required int id,
  });
  // Elimina una tarjeta de credito
  Future<Either<Failure, CreditCard>> deleteCreditCardById({required int id});
}
