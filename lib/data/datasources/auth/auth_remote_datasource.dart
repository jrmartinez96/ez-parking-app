import 'dart:convert';

import 'package:ez_parking_app/data/models/auth/signup_success_model.dart';
import 'package:http/http.dart' as http;
import 'package:ez_parking_app/constants/http_constants.dart';
import 'package:ez_parking_app/core/errors/exceptions.dart';
import 'package:ez_parking_app/data/models/auth/user_session_model.dart';
import 'package:ez_parking_app/data/models/server_error_model.dart';
import 'package:http/http.dart';

abstract class AuthRemoteDataSource {
  // Login del usuario
  Future<UserSessionModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  // Registro del usuario
  Future<SignupSuccessModel> signup({
    required String email,
    required String name,
    required String lastname,
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

    final response = await _post(url: '$urlEndpoint/auth/login/', body: body);

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

  @override
  Future<SignupSuccessModel> signup(
      {required String email, required String name, required String lastname, required String password}) async {
    final body = {
      'email': email,
      'name': name,
      'lastName': lastname,
      'password': password,
    };

    final response = await _post(url: '$urlEndpoint/auth/register/', body: body);

    if (response.statusCode == 200) {
      try {
        return signupSuccessModelFromJson(utf8.decode(response.bodyBytes));
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

  Future<Response> _post({required String url, required Map<String, dynamic> body}) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Accept-Language': 'es-gt',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    return response;
  }
}
