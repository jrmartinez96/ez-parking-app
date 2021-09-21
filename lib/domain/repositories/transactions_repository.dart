import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';

abstract class TransactionsRepository {
  // Solicita un listado de transacciones
  Future<Either<Failure, TransactionQuery>> getTransactions();
  // Solicita un listado de transacciones a partir de una url
  Future<Either<Failure, TransactionQuery>> getTransactionsByUrl({required String url});
}
