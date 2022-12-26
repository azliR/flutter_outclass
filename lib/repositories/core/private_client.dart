import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';

class PrivateClient {
  PrivateClient({Dio? httpClient})
      : _httpClient = (httpClient ?? Dio())
          ..interceptors.add(_fresh)
          ..interceptors.add(
            LogInterceptor(request: false, responseHeader: false),
          );

  static var _refreshCount = 0;
  static final _fresh = Fresh.oAuth2(
    tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
    refreshToken: (token, client) async {
      print('refreshing token...');
      await Future<void>.delayed(const Duration(seconds: 1));
      if (Random().nextInt(3) == 0) {
        print('token revoked!');
        throw RevokeTokenException();
      }
      print('token refreshed!');
      _refreshCount++;
      return OAuth2Token(
        accessToken: 'access_token_$_refreshCount',
        refreshToken: 'refresh_token_$_refreshCount',
      );
    },
    shouldRefresh: (_) => Random().nextInt(3) == 0,
  );

  final Dio _httpClient;

  Stream<AuthenticationStatus> get authenticationStatus =>
      _fresh.authenticationStatus;

  Future<void> authenticate({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    await _fresh.setToken(
      const OAuth2Token(
        accessToken: 'initial_access_token',
        refreshToken: 'initial_refresh_token',
      ),
    );
  }

  Future<void> unauthenticate() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    await _fresh.setToken(null);
  }
}
