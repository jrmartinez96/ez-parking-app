import 'dart:convert';

import 'package:ez_parking_app/domain/entities/auth/reset_password_response.dart';

ResetPasswordResponseModel resetPasswordResponseModelFromJson(String str) =>
    ResetPasswordResponseModel.fromJson(json.decode(str) as Map<String, dynamic>);

class ResetPasswordResponseModel extends ResetPasswordResponse {
  ResetPasswordResponseModel({
    required String status,
  }) : super(status: status);

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) => ResetPasswordResponseModel(
        status: json['status'] as String,
      );
}
