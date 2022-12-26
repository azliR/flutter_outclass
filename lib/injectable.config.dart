// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:outclass/blocs/auth/auth_cubit.dart' as _i3;
import 'package:outclass/blocs/auth/sign_in/sign_in_cubit.dart' as _i6;
import 'package:outclass/repositories/auth_repository.dart' as _i5;
import 'package:outclass/repositories/core/client_injectable_module.dart'
    as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final clientInjectableModule = _$ClientInjectableModule();
    gh.factory<_i3.AuthCubit>(() => _i3.AuthCubit());
    gh.factory<_i4.BaseOptions>(() => clientInjectableModule.options);
    gh.lazySingleton<_i4.Dio>(() => clientInjectableModule.dio);
    gh.lazySingleton<_i5.AuthRepository>(
        () => _i5.AuthRepository(gh<_i4.Dio>()));
    gh.factory<_i6.SignInCubit>(
        () => _i6.SignInCubit(gh<_i5.AuthRepository>()));
    return this;
  }
}

class _$ClientInjectableModule extends _i7.ClientInjectableModule {}
