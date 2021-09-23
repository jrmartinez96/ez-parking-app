part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded({required this.transaction});

  final Transaction transaction;
}

class HomeError extends HomeState {
  HomeError({required this.message, required this.failure});

  final String message;
  final Failure failure;
}
