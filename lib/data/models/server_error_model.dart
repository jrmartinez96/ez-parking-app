import 'dart:convert';

ServerErrorModel serverErrorModelFromJson(String str) =>
    ServerErrorModel.fromJson(json.decode(str) as Map<String, dynamic>);

class ServerErrorModel {
  ServerErrorModel({
    required this.message,
    required this.statusCode,
    required this.errors,
  });

  factory ServerErrorModel.fromJson(Map<String, dynamic> json) => ServerErrorModel(
        message: json['message'] as String,
        statusCode: json['status_code'] as int,
        errors: json['errors'],
      );

  final String message;
  final int statusCode;
  final dynamic errors;
}
