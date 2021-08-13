import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ez_parking_app/constants/http_constants.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';

import 'package:ez_parking_app/data/models/auth/forgot_password_response_model.dart';
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
      'User': email,
      'Password': password,
      'usingLogin': 'CLIEN',
    };

    // No se le agrega header de Content-Type porque tiene que ser x-www-urlencoded unicamente para este endpoint
    final response = await client.post(
      Uri.parse('$urlEndpoint/User/Login'),
      body: body,
    );

    if (response.statusCode == 200) {
      try {
        return userSessionModelFromJson(response.body);
      } catch (_, __) {
        ServerErrorModel serverErrorModel;
        try {
          serverErrorModel = serverErrorModelFromJson(response.body);
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
        serverErrorModel = serverErrorModelFromJson(response.body);
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
