import 'dart:convert';

import 'package:ez_parking_app/data/models/credit_cards/credit_card_model.dart';
import 'package:http/http.dart' as http;
import 'package:ez_parking_app/constants/http_constants.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/data/models/server_error_model.dart';
import 'package:http/http.dart';

abstract class CreditCardsRemoteDataSource {
  // Solicita las tarjetas de credito del usuario
  Future<List<CreditCardModel>> getCreditCards({
    required String authToken,
  });
  // Crea una tarjeta de credito
  Future<CreditCardModel> createCreditCard({
    required String authToken,
    required String cardNumber,
    required String holder,
    required String expirationDate,
  });
  // Solicita una tarjeta de credito po id
  Future<CreditCardModel> getCreditCardById({
    required String authToken,
    required int id,
  });
  // Actualiza la informacion de una tarjeta de credito
  Future<CreditCardModel> updateCreditCardById({
    required String authToken,
    required String cardNumber,
    required String holder,
    required String expirationDate,
    required int id,
  });
  // Solicita una tarjeta de credito po id
  Future<CreditCardModel> deleteCreditCardById({
    required String authToken,
    required int id,
  });
}

class CreditCardsRemoteDataSourceImpl implements CreditCardsRemoteDataSource {
  CreditCardsRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<List<CreditCardModel>> getCreditCards({required String authToken}) async {
    final response = await _getWithAuth(
      url: '$urlEndpoint/credit-card/',
      authToken: authToken,
    );

    if (response.statusCode == 200) {
      try {
        return creditCardModelListFromJson(utf8.decode(response.bodyBytes));
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
  Future<CreditCardModel> createCreditCard({
    required String authToken,
    required String cardNumber,
    required String holder,
    required String expirationDate,
  }) async {
    final body = {
      'number': cardNumber,
      'holder': holder,
      'expiration_date': expirationDate,
    };

    final response = await _postWithAuth(
      url: '$urlEndpoint/credit-card/',
      body: body,
      authToken: authToken,
    );

    if (response.statusCode == 200) {
      try {
        return creditCardModelFromJson(utf8.decode(response.bodyBytes));
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
  Future<CreditCardModel> getCreditCardById({required String authToken, required int id}) async {
    final response = await _getWithAuth(
      url: '$urlEndpoint/credit-card/$id',
      authToken: authToken,
    );

    if (response.statusCode == 200) {
      try {
        return creditCardModelFromJson(utf8.decode(response.bodyBytes));
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
  Future<CreditCardModel> updateCreditCardById({
    required String authToken,
    required String cardNumber,
    required String holder,
    required String expirationDate,
    required int id,
  }) async {
    final body = {
      'number': cardNumber,
      'holder': holder,
      'expiration_date': expirationDate,
    };

    final response = await _putWithAuth(
      url: '$urlEndpoint/credit-card/$id',
      body: body,
      authToken: authToken,
    );

    if (response.statusCode == 200) {
      try {
        return creditCardModelFromJson(utf8.decode(response.bodyBytes));
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
  Future<CreditCardModel> deleteCreditCardById({required String authToken, required int id}) async {
    final response = await _deleteWithAuth(
      url: '$urlEndpoint/credit-card/$id',
      authToken: authToken,
    );

    if (response.statusCode == 200) {
      try {
        return creditCardModelFromJson(utf8.decode(response.bodyBytes));
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

  Future<Response> _putWithAuth(
      {required String url, required Map<String, dynamic> body, required String authToken}) async {
    final response = await client.put(
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

  Future<Response> _deleteWithAuth({required String url, required String authToken}) async {
    final response = await client.delete(
      Uri.parse(url),
      headers: {
        'Accept-Language': 'es-gt',
        'Authorization': 'Bearer $authToken',
      },
    );

    return response;
  }
}
