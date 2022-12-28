// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:fresh_dio/fresh_dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:outclass/blocs/auth/auth_cubit.dart' as _i15;
import 'package:outclass/blocs/auth/sign_in/sign_in_cubit.dart' as _i6;
import 'package:outclass/blocs/home/account/account_cubit.dart' as _i14;
import 'package:outclass/blocs/home/directories/add_folder/add_folder_cubit.dart'
    as _i8;
import 'package:outclass/blocs/home/directories/add_post/add_post_cubit.dart'
    as _i9;
import 'package:outclass/blocs/home/directories/directories_cubit.dart' as _i13;
import 'package:outclass/repositories/auth_repository.dart' as _i10;
import 'package:outclass/repositories/classroom_member_repository.dart' as _i11;
import 'package:outclass/repositories/classroom_repository.dart' as _i12;
import 'package:outclass/repositories/core/client_injectable_module.dart'
    as _i16;
import 'package:outclass/repositories/directory_repository.dart' as _i4;
import 'package:outclass/repositories/token_repository.dart' as _i7;

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
    gh.factory<_i3.BaseOptions>(() => clientInjectableModule.options);
    gh.lazySingleton<_i3.Dio>(() => clientInjectableModule.dio);
    gh.lazySingleton<_i4.DirectoryRepository>(
        () => _i4.DirectoryRepository(gh<_i3.Dio>()));
    gh.factory<_i5.Fresh<_i5.OAuth2Token>>(() => clientInjectableModule.fresh);
    gh.factory<_i6.SignInCubit>(() => _i6.SignInCubit());
    gh.lazySingleton<_i7.TokenRepository>(() => _i7.TokenRepository(
          gh<_i5.Dio>(),
          gh<_i5.Fresh<_i5.OAuth2Token>>(),
        ));
    gh.factory<_i8.AddFolderCubit>(
        () => _i8.AddFolderCubit(gh<_i4.DirectoryRepository>()));
    gh.factory<_i9.AddPostCubit>(
        () => _i9.AddPostCubit(gh<_i4.DirectoryRepository>()));
    gh.lazySingleton<_i10.AuthRepository>(
        () => _i10.AuthRepository(gh<_i3.Dio>()));
    gh.lazySingleton<_i11.ClassroomMemberRepository>(
        () => _i11.ClassroomMemberRepository(gh<_i3.Dio>()));
    gh.lazySingleton<_i12.ClassroomRepository>(
        () => _i12.ClassroomRepository(gh<_i3.Dio>()));
    gh.factory<_i13.DirectoriesCubit>(
        () => _i13.DirectoriesCubit(gh<_i4.DirectoryRepository>()));
    gh.factory<_i14.AccountCubit>(
        () => _i14.AccountCubit(gh<_i11.ClassroomMemberRepository>()));
    gh.factory<_i15.AuthCubit>(() => _i15.AuthCubit(
          gh<_i10.AuthRepository>(),
          gh<_i12.ClassroomRepository>(),
          gh<_i7.TokenRepository>(),
        ));
    return this;
  }
}

class _$ClientInjectableModule extends _i16.ClientInjectableModule {}
