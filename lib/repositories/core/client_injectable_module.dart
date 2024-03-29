import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/dtos/token_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/repositories/core/cache_manager.dart';

@module
abstract class ClientInjectableModule {
  final options = BaseOptions(
    baseUrl: 'https://api.outclass.azlir.my.id/api/v1',
    // baseUrl: 'https://localhost:20109/api/v1',
  );

  @lazySingleton
  final fresh = Fresh.oAuth2(
    tokenStorage: InMemoryTokenStorage(),
    refreshToken: (token, httpClient) async {
      final refreshToken = token?.refreshToken;
      if (refreshToken == null) {
        throw DioException(
          requestOptions: RequestOptions(path: '/user/refresh'),
          error: 'Refresh token is null',
        );
      }

      final authCubit = getIt<AuthCubit>();
      final newToken = await authCubit.renewToken(
        renewTokenDto: RenewTokenDto(refreshToken: refreshToken),
      );

      if (newToken == null) {
        throw DioException(
          requestOptions: RequestOptions(path: '/user/refresh'),
          error: 'Failed to refresh token',
        );
      }
      return newToken;
    },
  );

  @lazySingleton
  Dio get dio {
    return Dio(options)..interceptors.add(fresh);
  }

  @lazySingleton
  CacheManager get cacheManager {
    return CacheManager(dio);
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
