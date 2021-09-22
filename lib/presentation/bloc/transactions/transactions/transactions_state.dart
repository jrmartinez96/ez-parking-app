part of 'transactions_cubit.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  TransactionsLoaded({
    required this.transactionQuery,
  });

  final TransactionQuery transactionQuery;
}

class TransactionsError extends TransactionsState {
  TransactionsError({required this.message, required this.failure});

  final String message;
  final Failure failure;
}
