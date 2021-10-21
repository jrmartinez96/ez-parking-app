import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';
import 'package:ez_parking_app/domain/use_cases/transactions/get_transactions.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit({required this.getTransactionsUC}) : super(TransactionsInitial());

  final GetTransactions getTransactionsUC;

  Future<void> getTransactions({String? url}) async {
    emit(TransactionsLoading());

    final failureOrTransactionQuery = await getTransactionsUC(url: url);

    emit(_eitherLoadedOrErrorState(failureOrTransactionQuery));
  }

  TransactionsState _eitherLoadedOrErrorState(Either<Failure, TransactionQuery> failureOrTransactionQuery) {
    return failureOrTransactionQuery.fold(
      (failure) => TransactionsError(message: _mapFailureToMessage(failure), failure: failure),
      (transactionQuery) => TransactionsLoaded(transactionQuery: transactionQuery),
    );
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
