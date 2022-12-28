import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/sign_in_dto.dart';
import 'package:outclass/models/auth/token.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._client);

  final Dio _client;

  Future<HttpResponse<Token>> signIn({
    required SignInDto signInDto,
  }) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/user/sign/in',
        data: signInDto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => Token.fromJson(data as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}
