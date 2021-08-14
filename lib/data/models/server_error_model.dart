import 'dart:convert';

ServerErrorModel serverErrorModelFromJson(String str) => ServerErrorModel.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class ServerErrorModel {
  ServerErrorModel({
    required this.message,
  });

  factory ServerErrorModel.fromJson(Map<String, dynamic> json) => ServerErrorModel(
        message: json['Message'] as String,
      );

  String message;
}
