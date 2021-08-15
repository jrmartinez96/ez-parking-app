import 'dart:convert';

import 'package:ez_parking_app/domain/entities/auth/signup_success.dart';

SignupSuccessModel signupSuccessModelFromJson(String str) =>
    SignupSuccessModel.fromJson(json.decode(str) as Map<String, dynamic>);

class SignupSuccessModel extends SignupSuccess {
  SignupSuccessModel({
    required int id,
    required String email,
    required String username,
    required String name,
    required String lastName,
  }) : super(id: id, email: email, username: username, name: name, lastName: lastName);

  factory SignupSuccessModel.fromJson(Map<String, dynamic> json) => SignupSuccessModel(
        id: json['id'] as int,
        email: json['email'] as String,
        username: json['username'] as String,
        name: json['name'] as String,
        lastName: json['lastName'] as String,
      );
}
