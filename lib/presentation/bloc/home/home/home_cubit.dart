import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';
import 'package:ez_parking_app/domain/use_cases/transactions/enter_or_exit_mall.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.enterOrExitMallUC}) : super(HomeInitial());
  final EnterOrExitMall enterOrExitMallUC;

  Future<void> enterOrExitMall({required String tagId}) async {
    emit(HomeLoading());

    final failureOrTransaction = await enterOrExitMallUC(tagId: tagId);

    emit(_eitherLoadedOrErrorState(failureOrTransaction));
  }

  HomeState _eitherLoadedOrErrorState(Either<Failure, Transaction> failureOrTransaction) {
    return failureOrTransaction.fold(
      (failure) => HomeError(message: _mapFailureToMessage(failure), failure: failure),
      (transaction) => HomeLoaded(transaction: transaction),
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
