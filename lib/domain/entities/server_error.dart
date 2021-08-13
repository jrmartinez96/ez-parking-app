import 'package:equatable/equatable.dart';

class ServerError extends Equatable {
  ServerError({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
