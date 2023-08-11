// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:outclass/models/directory/folder.dart' as _i21;
import 'package:outclass/models/directory/post.dart' as _i22;
import 'package:outclass/views/auth/sign_in/sign_in_page.dart' as _i17;
import 'package:outclass/views/auth/sign_in/sign_up_page.dart' as _i18;
import 'package:outclass/views/classroom/create_classroom.dart' as _i6;
import 'package:outclass/views/classroom/join_insert_student_id_page.dart'
    as _i12;
import 'package:outclass/views/classroom/join_page.dart' as _i13;
import 'package:outclass/views/classroom/scan_page.dart' as _i15;
import 'package:outclass/views/home-wrapper/account/account_page.dart' as _i1;
import 'package:outclass/views/home-wrapper/account/account_wrapper_page.dart'
    as _i2;
import 'package:outclass/views/home-wrapper/calendar/calendar_page.dart' as _i5;
import 'package:outclass/views/home-wrapper/directories/add_folder_dialog.dart'
    as _i3;
import 'package:outclass/views/home-wrapper/directories/add_post_dialog.dart'
    as _i4;
import 'package:outclass/views/home-wrapper/directories/directories_page.dart'
    as _i7;
import 'package:outclass/views/home-wrapper/directories/directories_share_type_wrapper_page.dart'
    as _i8;
import 'package:outclass/views/home-wrapper/directories/directories_tab_wrapper_page.dart'
    as _i9;
import 'package:outclass/views/home-wrapper/directories/directories_wrapper_page.dart'
    as _i10;
import 'package:outclass/views/home-wrapper/home_wrapper_page.dart' as _i11;
import 'package:outclass/views/home-wrapper/overview/overview_page.dart'
    as _i14;
import 'package:outclass/views/home-wrapper/settings/settings_page.dart'
    as _i16;

abstract class $AppRouter extends _i19.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    AccountRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i1.AccountPage()),
      );
    },
    AccountWrapperRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AccountWrapperPage(),
      );
    },
    AddFolderDialogRoute.name: (routeData) {
      final args = routeData.argsAs<AddFolderDialogRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(
            child: _i3.AddFolderDialog(
          key: args.key,
          shareType: args.shareType,
          parentId: args.parentId,
          existingFolder: args.existingFolder,
          onFolderCreated: args.onFolderCreated,
        )),
      );
    },
    AddPostDialogRoute.name: (routeData) {
      final args = routeData.argsAs<AddPostDialogRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(
            child: _i4.AddPostDialog(
          key: args.key,
          shareType: args.shareType,
          parentId: args.parentId,
          existingPost: args.existingPost,
          onPostCreated: args.onPostCreated,
        )),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CalendarPage(),
      );
    },
    CreateClassroomRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i6.CreateClassroomPage()),
      );
    },
    DirectoriesRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<DirectoriesRouteArgs>(
          orElse: () => DirectoriesRouteArgs(
                shareType: pathParams.getString(
                  'shareType',
                  'class',
                ),
                parentId: queryParams.getString(
                  'parentId',
                  '',
                ),
              ));
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(
            child: _i7.DirectoriesPage(
          key: args.key,
          shareType: args.shareType,
          parentId: args.parentId,
        )),
      );
    },
    DirectoriesShareTypeWrapperRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.DirectoriesShareTypeWrapperPage(),
      );
    },
    DirectoriesTabWrapperRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.DirectoriesTabWrapperPage(),
      );
    },
    DirectoriesWrapperRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i10.DirectoriesWrapperPage()),
      );
    },
    HomeWrapperRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i11.HomeWrapperPage()),
      );
    },
    JoinInsertStudentIdRoute.name: (routeData) {
      final args = routeData.argsAs<JoinInsertStudentIdRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(
            child: _i12.JoinInsertStudentIdPage(
          key: args.key,
          classCode: args.classCode,
        )),
      );
    },
    JoinRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i13.JoinPage()),
      );
    },
    OverviewRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i14.OverviewPage()),
      );
    },
    ScanRoute.name: (routeData) {
      final args =
          routeData.argsAs<ScanRouteArgs>(orElse: () => const ScanRouteArgs());
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.ScanPage(key: args.key),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.SettingsPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i17.SignInPage()),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i18.SignUpPage()),
      );
    },
  };
}

/// generated route for
/// [_i1.AccountPage]
class AccountRoute extends _i19.PageRouteInfo<void> {
  const AccountRoute({List<_i19.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountWrapperPage]
class AccountWrapperRoute extends _i19.PageRouteInfo<void> {
  const AccountWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          AccountWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountWrapperRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddFolderDialog]
class AddFolderDialogRoute
    extends _i19.PageRouteInfo<AddFolderDialogRouteArgs> {
  AddFolderDialogRoute({
    _i20.Key? key,
    required String shareType,
    required String parentId,
    _i21.Folder? existingFolder,
    required void Function(_i21.Folder) onFolderCreated,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          AddFolderDialogRoute.name,
          args: AddFolderDialogRouteArgs(
            key: key,
            shareType: shareType,
            parentId: parentId,
            existingFolder: existingFolder,
            onFolderCreated: onFolderCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFolderDialogRoute';

  static const _i19.PageInfo<AddFolderDialogRouteArgs> page =
      _i19.PageInfo<AddFolderDialogRouteArgs>(name);
}

class AddFolderDialogRouteArgs {
  const AddFolderDialogRouteArgs({
    this.key,
    required this.shareType,
    required this.parentId,
    this.existingFolder,
    required this.onFolderCreated,
  });

  final _i20.Key? key;

  final String shareType;

  final String parentId;

  final _i21.Folder? existingFolder;

  final void Function(_i21.Folder) onFolderCreated;

  @override
  String toString() {
    return 'AddFolderDialogRouteArgs{key: $key, shareType: $shareType, parentId: $parentId, existingFolder: $existingFolder, onFolderCreated: $onFolderCreated}';
  }
}

/// generated route for
/// [_i4.AddPostDialog]
class AddPostDialogRoute extends _i19.PageRouteInfo<AddPostDialogRouteArgs> {
  AddPostDialogRoute({
    _i20.Key? key,
    required String shareType,
    required String parentId,
    _i22.Post? existingPost,
    required void Function(_i22.Post) onPostCreated,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          AddPostDialogRoute.name,
          args: AddPostDialogRouteArgs(
            key: key,
            shareType: shareType,
            parentId: parentId,
            existingPost: existingPost,
            onPostCreated: onPostCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'AddPostDialogRoute';

  static const _i19.PageInfo<AddPostDialogRouteArgs> page =
      _i19.PageInfo<AddPostDialogRouteArgs>(name);
}

class AddPostDialogRouteArgs {
  const AddPostDialogRouteArgs({
    this.key,
    required this.shareType,
    required this.parentId,
    this.existingPost,
    required this.onPostCreated,
  });

  final _i20.Key? key;

  final String shareType;

  final String parentId;

  final _i22.Post? existingPost;

  final void Function(_i22.Post) onPostCreated;

  @override
  String toString() {
    return 'AddPostDialogRouteArgs{key: $key, shareType: $shareType, parentId: $parentId, existingPost: $existingPost, onPostCreated: $onPostCreated}';
  }
}

/// generated route for
/// [_i5.CalendarPage]
class CalendarRoute extends _i19.PageRouteInfo<void> {
  const CalendarRoute({List<_i19.PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CreateClassroomPage]
class CreateClassroomRoute extends _i19.PageRouteInfo<void> {
  const CreateClassroomRoute({List<_i19.PageRouteInfo>? children})
      : super(
          CreateClassroomRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateClassroomRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DirectoriesPage]
class DirectoriesRoute extends _i19.PageRouteInfo<DirectoriesRouteArgs> {
  DirectoriesRoute({
    _i20.Key? key,
    String shareType = 'class',
    String parentId = '',
    List<_i19.PageRouteInfo>? children,
  }) : super(
          DirectoriesRoute.name,
          args: DirectoriesRouteArgs(
            key: key,
            shareType: shareType,
            parentId: parentId,
          ),
          rawPathParams: {'shareType': shareType},
          rawQueryParams: {'parentId': parentId},
          initialChildren: children,
        );

  static const String name = 'DirectoriesRoute';

  static const _i19.PageInfo<DirectoriesRouteArgs> page =
      _i19.PageInfo<DirectoriesRouteArgs>(name);
}

class DirectoriesRouteArgs {
  const DirectoriesRouteArgs({
    this.key,
    this.shareType = 'class',
    this.parentId = '',
  });

  final _i20.Key? key;

  final String shareType;

  final String parentId;

  @override
  String toString() {
    return 'DirectoriesRouteArgs{key: $key, shareType: $shareType, parentId: $parentId}';
  }
}

/// generated route for
/// [_i8.DirectoriesShareTypeWrapperPage]
class DirectoriesShareTypeWrapperRoute extends _i19.PageRouteInfo<void> {
  const DirectoriesShareTypeWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          DirectoriesShareTypeWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'DirectoriesShareTypeWrapperRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i9.DirectoriesTabWrapperPage]
class DirectoriesTabWrapperRoute extends _i19.PageRouteInfo<void> {
  const DirectoriesTabWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          DirectoriesTabWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'DirectoriesTabWrapperRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i10.DirectoriesWrapperPage]
class DirectoriesWrapperRoute extends _i19.PageRouteInfo<void> {
  const DirectoriesWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          DirectoriesWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'DirectoriesWrapperRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i11.HomeWrapperPage]
class HomeWrapperRoute extends _i19.PageRouteInfo<void> {
  const HomeWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          HomeWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i12.JoinInsertStudentIdPage]
class JoinInsertStudentIdRoute
    extends _i19.PageRouteInfo<JoinInsertStudentIdRouteArgs> {
  JoinInsertStudentIdRoute({
    _i20.Key? key,
    required String classCode,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          JoinInsertStudentIdRoute.name,
          args: JoinInsertStudentIdRouteArgs(
            key: key,
            classCode: classCode,
          ),
          initialChildren: children,
        );

  static const String name = 'JoinInsertStudentIdRoute';

  static const _i19.PageInfo<JoinInsertStudentIdRouteArgs> page =
      _i19.PageInfo<JoinInsertStudentIdRouteArgs>(name);
}

class JoinInsertStudentIdRouteArgs {
  const JoinInsertStudentIdRouteArgs({
    this.key,
    required this.classCode,
  });

  final _i20.Key? key;

  final String classCode;

  @override
  String toString() {
    return 'JoinInsertStudentIdRouteArgs{key: $key, classCode: $classCode}';
  }
}

/// generated route for
/// [_i13.JoinPage]
class JoinRoute extends _i19.PageRouteInfo<void> {
  const JoinRoute({List<_i19.PageRouteInfo>? children})
      : super(
          JoinRoute.name,
          initialChildren: children,
        );

  static const String name = 'JoinRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i14.OverviewPage]
class OverviewRoute extends _i19.PageRouteInfo<void> {
  const OverviewRoute({List<_i19.PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i15.ScanPage]
class ScanRoute extends _i19.PageRouteInfo<ScanRouteArgs> {
  ScanRoute({
    _i20.Key? key,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ScanRoute.name,
          args: ScanRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ScanRoute';

  static const _i19.PageInfo<ScanRouteArgs> page =
      _i19.PageInfo<ScanRouteArgs>(name);
}

class ScanRouteArgs {
  const ScanRouteArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'ScanRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.SettingsPage]
class SettingsRoute extends _i19.PageRouteInfo<void> {
  const SettingsRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SignInPage]
class SignInRoute extends _i19.PageRouteInfo<void> {
  const SignInRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i18.SignUpPage]
class SignUpRoute extends _i19.PageRouteInfo<void> {
  const SignUpRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}
