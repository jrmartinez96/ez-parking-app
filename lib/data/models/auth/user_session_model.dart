import 'dart:convert';

import 'package:ez_parking_app/domain/entities/auth/user_session.dart';

UserSessionModel userSessionModelFromJson(String str) => UserSessionModel.fromJson(json.decode(str));

class UserSessionModel extends UserSession {
  UserSessionModel({
    required accesToken,
    required expires,
    required keyRecovery,
    required userId,
    required time,
    required companyId,
    required companyName,
    required viewForm,
    required userName,
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
        accesToken: json['AccesToken'],
        expires: DateTime.parse(json['Expires']),
        keyRecovery: json['KeyRecovery'],
        userId: json['UserId'],
        time: json['Time'],
        companyId: json['CompanyID'],
        companyName: json['CompanyName'],
        viewForm: json['ViewForm'],
        userName: json['UserName'],
      );
}
