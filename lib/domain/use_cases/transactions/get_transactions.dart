import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';
import 'package:ez_parking_app/domain/repositories/transactions_repository.dart';

class GetTransactions {
  GetTransactions(this.transactionsRepository);

  final TransactionsRepository transactionsRepository;

  Future<Either<Failure, TransactionQuery>> call({String? url}) async {
    if (url == null) {
      return transactionsRepository.getTransactions();
    } else {
      return transactionsRepository.getTransactionsByUrl(url: url);
    }
  }
}
