// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:fresh_dio/fresh_dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:outclass/blocs/auth/auth_cubit.dart' as _i24;
import 'package:outclass/blocs/auth/sign_in/sign_in_cubit.dart' as _i12;
import 'package:outclass/blocs/auth/sign_up/sign_up_cubit.dart' as _i13;
import 'package:outclass/blocs/classroom/create_classroom/create_classroom_cubit.dart'
    as _i5;
import 'package:outclass/blocs/classroom/join/join_cubit.dart' as _i10;
import 'package:outclass/blocs/home/account/account_cubit.dart' as _i23;
import 'package:outclass/blocs/home/calendar/calendar_cubit.dart' as _i19;
import 'package:outclass/blocs/home/directories/add_folder/add_folder_cubit.dart'
    as _i16;
import 'package:outclass/blocs/home/directories/add_post/add_post_cubit.dart'
    as _i17;
import 'package:outclass/blocs/home/directories/directories_cubit.dart' as _i22;
import 'package:outclass/blocs/home/directories_wrapper/directories_wrapper_cubit.dart'
    as _i6;
import 'package:outclass/blocs/home/overview/overview_cubit.dart' as _i11;
import 'package:outclass/repositories/auth_repository.dart' as _i18;
import 'package:outclass/repositories/classroom_member_repository.dart' as _i20;
import 'package:outclass/repositories/classroom_repository.dart' as _i21;
import 'package:outclass/repositories/core/cache_manager.dart' as _i4;
import 'package:outclass/repositories/core/client_injectable_module.dart'
    as _i25;
import 'package:outclass/repositories/directory_repository.dart' as _i7;
import 'package:outclass/repositories/event_repository.dart' as _i8;
import 'package:outclass/repositories/task_repository.dart' as _i14;
import 'package:outclass/repositories/token_repository.dart' as _i15;

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
    gh.factory<_i5.CreateClassroomCubit>(() => _i5.CreateClassroomCubit());
    gh.lazySingleton<_i3.Dio>(() => clientInjectableModule.dio);
    gh.factory<_i6.DirectoriesWrapperCubit>(
        () => _i6.DirectoriesWrapperCubit());
    gh.lazySingleton<_i7.DirectoryRepository>(() => _i7.DirectoryRepository(
          gh<_i3.Dio>(),
          gh<_i4.CacheManager>(),
        ));
    gh.lazySingleton<_i8.EventRepository>(
        () => _i8.EventRepository(gh<_i3.Dio>()));
    gh.factory<_i9.Fresh<_i9.OAuth2Token>>(() => clientInjectableModule.fresh);
    gh.factory<_i10.JoinCubit>(() => _i10.JoinCubit());
    gh.factory<_i11.OverviewCubit>(() => _i11.OverviewCubit());
    gh.factory<_i12.SignInCubit>(() => _i12.SignInCubit());
    gh.factory<_i13.SignUpCubit>(() => _i13.SignUpCubit());
    gh.lazySingleton<_i14.TaskRepository>(
        () => _i14.TaskRepository(gh<_i3.Dio>()));
    gh.lazySingleton<_i15.TokenRepository>(() => _i15.TokenRepository(
          gh<_i3.Dio>(),
          gh<_i9.Fresh<_i9.OAuth2Token>>(),
        ));
    gh.factory<_i16.AddFolderCubit>(
        () => _i16.AddFolderCubit(gh<_i7.DirectoryRepository>()));
    gh.factory<_i17.AddPostCubit>(
        () => _i17.AddPostCubit(gh<_i7.DirectoryRepository>()));
    gh.lazySingleton<_i18.AuthRepository>(
        () => _i18.AuthRepository(gh<_i3.Dio>()));
    gh.factory<_i19.CalendarCubit>(() => _i19.CalendarCubit(
          gh<_i8.EventRepository>(),
          gh<_i14.TaskRepository>(),
        ));
    gh.lazySingleton<_i20.ClassroomMemberRepository>(
        () => _i20.ClassroomMemberRepository(gh<_i3.Dio>()));
    gh.lazySingleton<_i21.ClassroomRepository>(
        () => _i21.ClassroomRepository(gh<_i3.Dio>()));
    gh.factory<_i22.DirectoriesCubit>(
        () => _i22.DirectoriesCubit(gh<_i7.DirectoryRepository>()));
    gh.factory<_i23.AccountCubit>(
        () => _i23.AccountCubit(gh<_i20.ClassroomMemberRepository>()));
    gh.factory<_i24.AuthCubit>(() => _i24.AuthCubit(
          gh<_i18.AuthRepository>(),
          gh<_i21.ClassroomRepository>(),
          gh<_i15.TokenRepository>(),
        ));
    return this;
  }
}

class _$ClientInjectableModule extends _i25.ClientInjectableModule {}
