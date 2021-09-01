import 'dart:convert';

RefreshTokenModel refreshTokenModelFromJson(String str) =>
    RefreshTokenModel.fromJson(json.decode(str) as Map<String, dynamic>);

class RefreshTokenModel {
  RefreshTokenModel({
    required this.access,
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
        access: json['access'] as String,
      );

  final String access;
}
