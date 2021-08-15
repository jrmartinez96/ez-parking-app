import 'dart:convert';

import 'package:ez_parking_app/domain/entities/auth/user_session.dart';

// ignore: non_constant_identifier_names
UserSessionModel userSessionModelFromJson(String str) =>
    UserSessionModel.fromJson(json.decode(str) as Map<String, dynamic>);

class UserSessionModel extends UserSession {
  UserSessionModel({
    required String refresh,
    required String access,
  }) : super(refresh: refresh, access: access);

  factory UserSessionModel.fromJson(Map<String, dynamic> json) => UserSessionModel(
        refresh: json['refresh'] as String,
        access: json['access'] as String,
      );
}
