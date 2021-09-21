import 'dart:convert';

import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';

TransactionQueryModel transactionQueryFromJson(String str) =>
    TransactionQueryModel.fromJson(json.decode(str) as Map<String, dynamic>);

class TransactionQueryModel extends TransactionQuery {
  TransactionQueryModel({
    required String? next,
    required String? previous,
    required List<TransactionModel> transactions,
  }) : super(
          next: next,
          previous: previous,
          transactions: transactions,
        );

  factory TransactionQueryModel.fromJson(Map<String, dynamic> json) => TransactionQueryModel(
        next: json['next'] as String?,
        previous: json['previous'] as String?,
        transactions: List<TransactionModel>.from((json['results'] as List).map<TransactionModel>(
          (dynamic x) => TransactionModel.fromJson(x as Map<String, dynamic>),
        )),
      );
}

class TransactionModel extends Transaction {
  TransactionModel({
    required String id,
    required MallModel mall,
    required DateTime enterTime,
    required DateTime exitTime,
    required double amount,
  }) : super(id: id, mall: mall, enterTime: enterTime, exitTime: exitTime, amount: amount);

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json['id'] as String,
        mall: MallModel.fromJson(json['mall'] as Map<String, dynamic>),
        enterTime: DateTime.parse(json['enterTime'] as String),
        exitTime: DateTime.parse(json['exitTime'] as String),
        amount: json['amount'] as double,
      );
}

class MallModel extends Mall {
  MallModel({
    required String name,
    required String address,
  }) : super(name: name, address: address);

  factory MallModel.fromJson(Map<String, dynamic> json) => MallModel(
        name: json['name'] as String,
        address: json['address'] as String,
      );
}
