import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ClientInjectableModule {
  final options = BaseOptions(
    baseUrl: 'http://192.168.254.188:5000',
  );

  @lazySingleton
  Dio get dio {
    return Dio(options)
      ..interceptors.add(
        Fresh.oAuth2(
          tokenStorage: InMemoryTokenStorage(),
          refreshToken: (token, httpClient) async {
            return OAuth2Token(
              accessToken: '',
              refreshToken: '',
              expiresIn: null,
            );
          },
        ),
      );
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
