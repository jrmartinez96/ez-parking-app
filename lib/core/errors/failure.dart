import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

// Failures generales de la app
class ServerFailure extends Failure {
  const ServerFailure({
    required this.code,
    required String message,
  }) : super(message: message);

  factory ServerFailure.fromException(ServerException exception) => ServerFailure(
        message: exception.message,
        code: exception.code,
      );

  final int code;
}

ServerFailure internetFailure() {
  return const ServerFailure(code: 0, message: 'Sin acceso a internet, por favor intenta mas tarde.');
}

class GeneralFailure extends Failure {
  const GeneralFailure({
    String message = 'Ha ocurrido un error inesperado',
  }) : super(message: message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    String message = 'Tu sesión ha terminado',
  }) : super(message: message);
}
