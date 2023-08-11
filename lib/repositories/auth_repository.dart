import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/sign_in_dto.dart';
import 'package:outclass/dtos/sign_up_dto.dart';
import 'package:outclass/models/auth/token.dart';
import 'package:outclass/models/auth/user.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._client);

  final Dio _client;

  Future<HttpResponse<Token>> signInWithEmailAndPassword({
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
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.badResponse) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => null,
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }

  Future<HttpResponse<SignUpResponse>> signUpWithEmailAndPassword({
    required SignUpDto signUpDto,
  }) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/user/sign/up',
        data: signUpDto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => SignUpResponse.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.badResponse) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => null,
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
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
