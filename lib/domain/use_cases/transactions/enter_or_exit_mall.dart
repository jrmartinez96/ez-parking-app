import 'package:dartz/dartz.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';
import 'package:ez_parking_app/domain/repositories/transactions_repository.dart';

class EnterOrExitMall {
  EnterOrExitMall(this.transactionsRepository);

  final TransactionsRepository transactionsRepository;

  Future<Either<Failure, Transaction>> call({required String tagId}) async {
    return transactionsRepository.enterOrExitMall(tagId: tagId);
  }
}
