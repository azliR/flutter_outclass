import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/token_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/models/auth/token.dart';
import 'package:outclass/repositories/token_repository.dart';

@module
abstract class ClientInjectableModule {
  final options = BaseOptions(
    baseUrl: 'https://outclass.api.azlir.my.id/api/v1',
  );

  @lazySingleton
  Fresh<OAuth2Token> get fresh {
    return Fresh.oAuth2(
      tokenStorage: InMemoryTokenStorage(),
      refreshToken: (token, httpClient) async {
        final refreshToken = token?.refreshToken;
        if (refreshToken != null) {
          final tokenRepository = getIt<TokenRepository>();
          final response = await tokenRepository.renewToken(
            renewTokenDto: RenewTokenDto(refreshToken: refreshToken),
          );
          if (response.success) {
            final token = Token.fromMap(response.data!);
            return tokenRepository.parseToken(token);
          }
        }
        throw DioError(
          requestOptions: RequestOptions(path: '/auth/refresh'),
          error: 'Refresh token is null',
        );
      },
    );
  }

  @lazySingleton
  Dio get dio {
    return Dio(options)..interceptors.add(fresh);
  }
}

// @prod
// @Injectable(as: ClientInjectableModule)
// class ProdClient extends ClientInjectableModule {
//   @override
//   final options = BaseOptions(
//     baseUrl: 'http://localhost:5000',
//   );
// }

// @dev
// @Injectable(as: ClientInjectableModule)
// class DevClient extends ClientInjectableModule {
//   @override
//   final options = BaseOptions(
//     baseUrl: 'http://localhost:5000',
//   );
// }
