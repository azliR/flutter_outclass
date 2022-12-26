import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/sign_in_dto.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._client);

  final Dio _client;

  Future<HttpResponse> signIn({
    required SignInDto signInDto,
  }) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/user/sign/in',
        data: signInDto.toJson(),
      );

      return HttpResponse.fromMap(response.data);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}
