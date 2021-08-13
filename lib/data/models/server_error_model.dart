import 'dart:convert';

ServerErrorModel serverErrorModelFromJson(String str) =>
    ServerErrorModel.fromJson(
      json.decode(str),
    );

class ServerErrorModel {
  ServerErrorModel({
    required this.message,
  });

  factory ServerErrorModel.fromJson(Map<String, dynamic> json) =>
      ServerErrorModel(
        message: json['Message'],
      );

  String message;
}
