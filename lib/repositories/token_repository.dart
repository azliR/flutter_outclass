import 'dart:developer';

import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/token_dto.dart';
import 'package:outclass/models/auth/token.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class TokenRepository {
  TokenRepository(this._client, this._fresh);

  final Dio _client;
  final Fresh<OAuth2Token> _fresh;

  Future<HttpResponse> renewToken({
    required RenewTokenDto renewTokenDto,
  }) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: renewTokenDto.toJson(),
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

  OAuth2Token parseToken(Token token) {
    final now = DateTime.now();
    final tokenExpiresIn = token.tokenExpiresIn;
    final difference = tokenExpiresIn.difference(now);

    return OAuth2Token(
      accessToken: token.accessToken,
      expiresIn: difference.inSeconds,
      refreshToken: token.refreshToken,
    );
  }

  void setToken(Token token) {
    _fresh.setToken(parseToken(token));
  }
}
