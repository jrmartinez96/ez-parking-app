import 'package:equatable/equatable.dart';

class ForgotPasswordResponse extends Equatable {
  const ForgotPasswordResponse({
    required this.succeeded,
    this.error,
    this.data,
    required this.accesDenied,
  });

  final bool succeeded;
  final String? error;
  final String? data;
  final bool accesDenied;

  @override
  List<Object?> get props => [succeeded, error, data, accesDenied];
}
