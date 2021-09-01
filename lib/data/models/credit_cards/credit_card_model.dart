import 'dart:convert';

import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';

// ignore: avoid_dynamic_calls
List<CreditCardModel> creditCardModelListFromJson(String str) =>
    List<Map<String, dynamic>>.from(json.decode(str) as List)
        .map<CreditCardModel>((x) => CreditCardModel.fromJson(x))
        .toList();

CreditCardModel creditCardModelFromJson(String str) =>
    CreditCardModel.fromJson(json.decode(str) as Map<String, dynamic>);

class CreditCardModel extends CreditCard {
  CreditCardModel({
    required String number,
    required String holder,
    required String expirationDate,
    required int id,
  }) : super(
          number: number,
          holder: holder,
          expirationDate: expirationDate,
          id: id,
        );

  factory CreditCardModel.fromJson(Map<String, dynamic> json) => CreditCardModel(
        number: json['number'] as String,
        holder: json['holder'] as String,
        expirationDate: json['expiration_date'] as String,
        id: json['id'] != null ? json['id'] as int : 0,
      );
}
