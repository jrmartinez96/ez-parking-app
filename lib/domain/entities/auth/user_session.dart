import 'package:equatable/equatable.dart';

class UserSession extends Equatable {
  const UserSession({
    required this.accesToken,
    required this.expires,
    required this.keyRecovery,
    required this.userId,
    required this.time,
    required this.companyId,
    required this.companyName,
    required this.viewForm,
    required this.userName,
  });

  final String accesToken;
  final DateTime expires;
  final bool keyRecovery;
  final int userId;
  final int time;
  final int companyId;
  final String companyName;
  final bool viewForm;
  final String userName;

  @override
  List<Object?> get props => [accesToken, expires, keyRecovery, userId, time, companyId, companyName, viewForm, userId];
}
