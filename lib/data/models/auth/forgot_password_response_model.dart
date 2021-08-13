import 'dart:convert';

import 'package:ez_parking_app/domain/entities/auth/forgot_password_response.dart';

ForgotPasswordResponseModel forgotPasswordResponseModelFromJson(String str) =>
    ForgotPasswordResponseModel.fromJson(json.decode(str));

class ForgotPasswordResponseModel extends ForgotPasswordResponse {
  ForgotPasswordResponseModel({
    required succeeded,
    error,
    data,
    required accesDenied,
  }) : super(
          succeeded: succeeded,
          error: error,
          data: data,
          accesDenied: accesDenied,
        );

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) => ForgotPasswordResponseModel(
        succeeded: json['Succeeded'],
        error: json['Error'],
        data: json['Data'],
        accesDenied: json['AccesDenied'],
      );
}
