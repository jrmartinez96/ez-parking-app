import 'dart:convert';

import 'package:ez_parking_app/domain/entities/auth/user_session.dart';

UserSessionModel userSessionModelFromJson(String str) =>
    UserSessionModel.fromJson(json.decode(str) as Map<String, dynamic>);

class UserSessionModel extends UserSession {
  const UserSessionModel({
    required String accesToken,
    required DateTime expires,
    required bool keyRecovery,
    required int userId,
    required int time,
    required int companyId,
    required String companyName,
    required bool viewForm,
    required String userName,
  }) : super(
          accesToken: accesToken,
          expires: expires,
          keyRecovery: keyRecovery,
          userId: userId,
          time: time,
          companyId: companyId,
          companyName: companyName,
          viewForm: viewForm,
          userName: userName,
        );
  factory UserSessionModel.fromJson(Map<String, dynamic> json) => UserSessionModel(
        accesToken: json['AccesToken'] as String,
        expires: DateTime.parse(json['Expires'] as String),
        keyRecovery: json['KeyRecovery'] as bool,
        userId: json['UserId'] as int,
        time: json['Time'] as int,
        companyId: json['CompanyID'] as int,
        companyName: json['CompanyName'] as String,
        viewForm: json['ViewForm'] as bool,
        userName: json['UserName'] as String,
      );
}
