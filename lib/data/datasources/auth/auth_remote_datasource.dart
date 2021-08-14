import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ez_parking_app/constants/http_constants.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/data/models/auth/user_session_model.dart';
import 'package:ez_parking_app/data/models/server_error_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserSessionModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<UserSessionModel> loginWithEmailAndPassword({required String email, required String password}) async {
    final body = {
      'email': email,
      'password': password,
    };

    // No se le agrega header de Content-Type porque tiene que ser x-www-urlencoded unicamente para este endpoint
    final response = await client.post(
      Uri.parse('$urlEndpoint/auth/login/'),
      headers: {
        'Accept-Language': 'es-gt',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      try {
        return userSessionModelFromJson(utf8.decode(response.bodyBytes));
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
}
