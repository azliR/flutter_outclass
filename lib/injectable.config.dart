// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:fresh_dio/fresh_dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:outclass/blocs/auth/auth_cubit.dart' as _i19;
import 'package:outclass/blocs/auth/sign_in/sign_in_cubit.dart' as _i8;
import 'package:outclass/blocs/home/account/account_cubit.dart' as _i18;
import 'package:outclass/blocs/home/calendar/calendar_cubit.dart' as _i14;
import 'package:outclass/blocs/home/directories/add_folder/add_folder_cubit.dart'
    as _i11;
import 'package:outclass/blocs/home/directories/add_post/add_post_cubit.dart'
    as _i12;
import 'package:outclass/blocs/home/directories/directories_cubit.dart' as _i17;
import 'package:outclass/repositories/auth_repository.dart' as _i13;
import 'package:outclass/repositories/classroom_member_repository.dart' as _i15;
import 'package:outclass/repositories/classroom_repository.dart' as _i16;
import 'package:outclass/repositories/core/cache_manager.dart' as _i4;
import 'package:outclass/repositories/core/client_injectable_module.dart'
    as _i20;
import 'package:outclass/repositories/directory_repository.dart' as _i5;
import 'package:outclass/repositories/event_repository.dart' as _i6;
import 'package:outclass/repositories/task_repository.dart' as _i9;
import 'package:outclass/repositories/token_repository.dart' as _i10;

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
    gh.lazySingleton<_i4.CacheManager>(
        () => clientInjectableModule.cacheManager);
    gh.lazySingleton<_i3.Dio>(() => clientInjectableModule.dio);
    gh.lazySingleton<_i5.DirectoryRepository>(() => _i5.DirectoryRepository(
          gh<_i3.Dio>(),
          gh<_i4.CacheManager>(),
        ));
    gh.lazySingleton<_i6.EventRepository>(
        () => _i6.EventRepository(gh<_i3.Dio>()));
    gh.factory<_i7.Fresh<_i7.OAuth2Token>>(() => clientInjectableModule.fresh);
    gh.factory<_i8.SignInCubit>(() => _i8.SignInCubit());
    gh.lazySingleton<_i9.TaskRepository>(
        () => _i9.TaskRepository(gh<_i3.Dio>()));
    gh.lazySingleton<_i10.TokenRepository>(() => _i10.TokenRepository(
          gh<_i7.Dio>(),
          gh<_i7.Fresh<_i7.OAuth2Token>>(),
        ));
    gh.factory<_i11.AddFolderCubit>(
        () => _i11.AddFolderCubit(gh<_i5.DirectoryRepository>()));
    gh.factory<_i12.AddPostCubit>(
        () => _i12.AddPostCubit(gh<_i5.DirectoryRepository>()));
    gh.lazySingleton<_i13.AuthRepository>(
        () => _i13.AuthRepository(gh<_i3.Dio>()));
    gh.factory<_i14.CalendarCubit>(() => _i14.CalendarCubit(
          gh<_i6.EventRepository>(),
          gh<_i9.TaskRepository>(),
        ));
    gh.lazySingleton<_i15.ClassroomMemberRepository>(
        () => _i15.ClassroomMemberRepository(gh<_i3.Dio>()));
    gh.lazySingleton<_i16.ClassroomRepository>(
        () => _i16.ClassroomRepository(gh<_i3.Dio>()));
    gh.factory<_i17.DirectoriesCubit>(
        () => _i17.DirectoriesCubit(gh<_i5.DirectoryRepository>()));
    gh.factory<_i18.AccountCubit>(
        () => _i18.AccountCubit(gh<_i15.ClassroomMemberRepository>()));
    gh.factory<_i19.AuthCubit>(() => _i19.AuthCubit(
          gh<_i13.AuthRepository>(),
          gh<_i16.ClassroomRepository>(),
          gh<_i10.TokenRepository>(),
        ));
    return this;
  }
}

class _$ClientInjectableModule extends _i20.ClientInjectableModule {}
