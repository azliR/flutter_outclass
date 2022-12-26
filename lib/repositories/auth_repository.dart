import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._client);

  final Dio _client;

  Future<void> signIn({required String email, required String password}) async {
    try {
      final response = await _client.post<HttpResponse>(
        '/user/sign/in',
        data: {
          'email': email,
          'password': password,
        },
      );
      print(response.data);
    } catch (e, stackTrace) {}
  }
}
