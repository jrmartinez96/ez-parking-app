import 'dart:convert';

import 'package:ez_parking_app/data/models/transactions/transaction_query_model.dart';
import 'package:http/http.dart' as http;
import 'package:ez_parking_app/constants/http_constants.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/data/models/server_error_model.dart';
import 'package:http/http.dart';

abstract class TransactionsRemoteDataSource {
  // Solicita las primeras transacciones de un usuario
  Future<TransactionQueryModel> getTransactions({
    required String authToken,
  });
  // Solicita las transacciones de un usuario por medio de una url
  Future<TransactionQueryModel> getTransactionsByUrl({required String authToken, required String url});
  // Solicita abrir una talanquera, ya sea para entrar o salir
  Future<TransactionModel> enterOrExitMall({required String authToken, required String tagId});
}

class TransactionsRemoteDataSourceImpl implements TransactionsRemoteDataSource {
  TransactionsRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<TransactionQueryModel> getTransactions({required String authToken}) async {
    final response = await _getWithAuth(
      url: '$urlEndpoint/transactions/',
      authToken: authToken,
    );

    if (response.statusCode == 200) {
      try {
        return transactionQueryFromJson(utf8.decode(response.bodyBytes));
      } catch (_, __) {
        ServerErrorModel serverErrorModel;
        try {
          serverErrorModel = serverErrorModelFromJson(utf8.decode(response.bodyBytes));
        } catch (_, __) {
          throw ServerException(
            'Intenta más tarde.',
            response.statusCode,
          );
        }
        throw ServerException(serverErrorModel.message);
      }
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      ServerErrorModel serverErrorModel;
      try {
        serverErrorModel = serverErrorModelFromJson(utf8.decode(response.bodyBytes));
      } on Exception catch (_, __) {
        throw ServerException(
          'Intenta más tarde.',
          response.statusCode,
        );
      }
      throw ServerException(
        serverErrorModel.message,
      );
    }
  }

  @override
  Future<TransactionQueryModel> getTransactionsByUrl({required String authToken, required String url}) async {
    final response = await _getWithAuth(
      url: url,
      authToken: authToken,
    );

    if (response.statusCode == 200) {
      try {
        return transactionQueryFromJson(utf8.decode(response.bodyBytes));
      } catch (_, __) {
        ServerErrorModel serverErrorModel;
        try {
          serverErrorModel = serverErrorModelFromJson(utf8.decode(response.bodyBytes));
        } catch (_, __) {
          throw ServerException(
            'Intenta más tarde.',
            response.statusCode,
          );
        }
        throw ServerException(serverErrorModel.message);
      }
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      ServerErrorModel serverErrorModel;
      try {
        serverErrorModel = serverErrorModelFromJson(utf8.decode(response.bodyBytes));
      } on Exception catch (_, __) {
        throw ServerException(
          'Intenta más tarde.',
          response.statusCode,
        );
      }
      throw ServerException(
        serverErrorModel.message,
      );
    }
  }

  @override
  Future<TransactionModel> enterOrExitMall({required String authToken, required String tagId}) async {
    final response = await _postWithAuth(
      url: '$urlEndpoint/transactions/open-mall-gate/',
      authToken: authToken,
      body: <String, dynamic>{
        'tagId': tagId,
      },
    );

    if (response.statusCode == 200) {
      try {
        return TransactionModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
      } catch (_, __) {
        ServerErrorModel serverErrorModel;
        try {
          serverErrorModel = serverErrorModelFromJson(utf8.decode(response.bodyBytes));
        } catch (_, __) {
          throw ServerException(
            'Intenta más tarde.',
            response.statusCode,
          );
        }
        throw ServerException(serverErrorModel.message);
      }
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      ServerErrorModel serverErrorModel;
      try {
        serverErrorModel = serverErrorModelFromJson(utf8.decode(response.bodyBytes));
      } on Exception catch (_, __) {
        throw ServerException(
          'Intenta más tarde.',
          response.statusCode,
        );
      }
      throw ServerException(
        serverErrorModel.message,
      );
    }
  }

  Future<Response> _postWithAuth(
      {required String url, required Map<String, dynamic> body, required String authToken}) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Accept-Language': 'es-gt',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode(body),
    );

    return response;
  }

  Future<Response> _getWithAuth({required String url, required String authToken}) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept-Language': 'es-gt',
        'Authorization': 'Bearer $authToken',
      },
    );

    return response;
  }
}
