// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter({
    GlobalKey<NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final AuthGuard authGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    SignInRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const SignInPage()),
      );
    },
    HomeWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const HomeWrapperPage(),
      );
    },
    OverviewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const OverviewPage(),
      );
    },
    CalendarRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CalendarPage()),
      );
    },
    DirectoriesTabWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    AccountWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    DirectoriesWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<DirectoriesWrapperRouteArgs>(
          orElse: () => const DirectoriesWrapperRouteArgs());
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: DirectoriesWrapperPage(key: args.key),
      );
    },
    AddFolderDialogRoute.name: (routeData) {
      final args = routeData.argsAs<AddFolderDialogRouteArgs>();
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: AddFolderDialog(
          key: args.key,
          shareType: args.shareType,
          parentId: args.parentId,
          existingFolder: args.existingFolder,
          onFolderCreated: args.onFolderCreated,
        )),
        fullscreenDialog: true,
      );
    },
    AddPostDialogRoute.name: (routeData) {
      final args = routeData.argsAs<AddPostDialogRouteArgs>();
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: AddPostDialog(
          key: args.key,
          shareType: args.shareType,
          parentId: args.parentId,
          existingPost: args.existingPost,
          onPostCreated: args.onPostCreated,
        )),
        fullscreenDialog: true,
      );
    },
    DirectoriesShareTypeWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    DirectoriesRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DirectoriesRouteArgs>(
          orElse: () => DirectoriesRouteArgs(
                shareType: pathParams.getString('shareType'),
                parentId: pathParams.getString('parentId'),
              ));
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DirectoriesPage(
          key: args.key,
          shareType: args.shareType,
          parentId: args.parentId,
        )),
      );
    },
    AccountRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const AccountPage()),
      );
    },
    SettingsRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SignInRoute.name,
          path: '/in',
        ),
        RouteConfig(
          HomeWrapperRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            RouteConfig(
              OverviewRoute.name,
              path: '',
              parent: HomeWrapperRoute.name,
            ),
            RouteConfig(
              CalendarRoute.name,
              path: 'calendar',
              parent: HomeWrapperRoute.name,
            ),
            RouteConfig(
              DirectoriesTabWrapperRoute.name,
              path: 'folders',
              parent: HomeWrapperRoute.name,
              children: [
                RouteConfig(
                  DirectoriesWrapperRoute.name,
                  path: '',
                  parent: DirectoriesTabWrapperRoute.name,
                  children: [
                    RouteConfig(
                      DirectoriesShareTypeWrapperRoute.name,
                      path: '',
                      parent: DirectoriesWrapperRoute.name,
                      children: [
                        RouteConfig(
                          '#redirect',
                          path: '',
                          parent: DirectoriesShareTypeWrapperRoute.name,
                          redirectTo: 'class/null',
                          fullMatch: true,
                        ),
                        RouteConfig(
                          DirectoriesRoute.name,
                          path: ':shareType/:parentId',
                          parent: DirectoriesShareTypeWrapperRoute.name,
                        ),
                      ],
                    )
                  ],
                ),
                RouteConfig(
                  AddFolderDialogRoute.name,
                  path: 'folder/add',
                  parent: DirectoriesTabWrapperRoute.name,
                ),
                RouteConfig(
                  AddPostDialogRoute.name,
                  path: 'post/add',
                  parent: DirectoriesTabWrapperRoute.name,
                ),
              ],
            ),
            RouteConfig(
              AccountWrapperRoute.name,
              path: 'account',
              parent: HomeWrapperRoute.name,
              children: [
                RouteConfig(
                  AccountRoute.name,
                  path: '',
                  parent: AccountWrapperRoute.name,
                ),
                RouteConfig(
                  SettingsRoute.name,
                  path: 'settings',
                  parent: AccountWrapperRoute.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/in',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [HomeWrapperPage]
class HomeWrapperRoute extends PageRouteInfo<void> {
  const HomeWrapperRoute({List<PageRouteInfo>? children})
      : super(
          HomeWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';
}

/// generated route for
/// [OverviewPage]
class OverviewRoute extends PageRouteInfo<void> {
  const OverviewRoute()
      : super(
          OverviewRoute.name,
          path: '',
        );

  static const String name = 'OverviewRoute';
}

/// generated route for
/// [CalendarPage]
class CalendarRoute extends PageRouteInfo<void> {
  const CalendarRoute()
      : super(
          CalendarRoute.name,
          path: 'calendar',
        );

  static const String name = 'CalendarRoute';
}

/// generated route for
/// [EmptyRouterPage]
class DirectoriesTabWrapperRoute extends PageRouteInfo<void> {
  const DirectoriesTabWrapperRoute({List<PageRouteInfo>? children})
      : super(
          DirectoriesTabWrapperRoute.name,
          path: 'folders',
          initialChildren: children,
        );

  static const String name = 'DirectoriesTabWrapperRoute';
}

/// generated route for
/// [EmptyRouterPage]
class AccountWrapperRoute extends PageRouteInfo<void> {
  const AccountWrapperRoute({List<PageRouteInfo>? children})
      : super(
          AccountWrapperRoute.name,
          path: 'account',
          initialChildren: children,
        );

  static const String name = 'AccountWrapperRoute';
}

/// generated route for
/// [DirectoriesWrapperPage]
class DirectoriesWrapperRoute
    extends PageRouteInfo<DirectoriesWrapperRouteArgs> {
  DirectoriesWrapperRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DirectoriesWrapperRoute.name,
          path: '',
          args: DirectoriesWrapperRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DirectoriesWrapperRoute';
}

class DirectoriesWrapperRouteArgs {
  const DirectoriesWrapperRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'DirectoriesWrapperRouteArgs{key: $key}';
  }
}

/// generated route for
/// [AddFolderDialog]
class AddFolderDialogRoute extends PageRouteInfo<AddFolderDialogRouteArgs> {
  AddFolderDialogRoute({
    Key? key,
    required String shareType,
    String? parentId,
    Folder? existingFolder,
    required void Function(Folder) onFolderCreated,
  }) : super(
          AddFolderDialogRoute.name,
          path: 'folder/add',
          args: AddFolderDialogRouteArgs(
            key: key,
            shareType: shareType,
            parentId: parentId,
            existingFolder: existingFolder,
            onFolderCreated: onFolderCreated,
          ),
        );

  static const String name = 'AddFolderDialogRoute';
}

class AddFolderDialogRouteArgs {
  const AddFolderDialogRouteArgs({
    this.key,
    required this.shareType,
    this.parentId,
    this.existingFolder,
    required this.onFolderCreated,
  });

  final Key? key;

  final String shareType;

  final String? parentId;

  final Folder? existingFolder;

  final void Function(Folder) onFolderCreated;

  @override
  String toString() {
    return 'AddFolderDialogRouteArgs{key: $key, shareType: $shareType, parentId: $parentId, existingFolder: $existingFolder, onFolderCreated: $onFolderCreated}';
  }
}

/// generated route for
/// [AddPostDialog]
class AddPostDialogRoute extends PageRouteInfo<AddPostDialogRouteArgs> {
  AddPostDialogRoute({
    Key? key,
    required String shareType,
    String? parentId,
    Post? existingPost,
    required void Function(Post) onPostCreated,
  }) : super(
          AddPostDialogRoute.name,
          path: 'post/add',
          args: AddPostDialogRouteArgs(
            key: key,
            shareType: shareType,
            parentId: parentId,
            existingPost: existingPost,
            onPostCreated: onPostCreated,
          ),
        );

  static const String name = 'AddPostDialogRoute';
}

class AddPostDialogRouteArgs {
  const AddPostDialogRouteArgs({
    this.key,
    required this.shareType,
    this.parentId,
    this.existingPost,
    required this.onPostCreated,
  });

  final Key? key;

  final String shareType;

  final String? parentId;

  final Post? existingPost;

  final void Function(Post) onPostCreated;

  @override
  String toString() {
    return 'AddPostDialogRouteArgs{key: $key, shareType: $shareType, parentId: $parentId, existingPost: $existingPost, onPostCreated: $onPostCreated}';
  }
}

/// generated route for
/// [EmptyRouterPage]
class DirectoriesShareTypeWrapperRoute extends PageRouteInfo<void> {
  const DirectoriesShareTypeWrapperRoute({List<PageRouteInfo>? children})
      : super(
          DirectoriesShareTypeWrapperRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'DirectoriesShareTypeWrapperRoute';
}

/// generated route for
/// [DirectoriesPage]
class DirectoriesRoute extends PageRouteInfo<DirectoriesRouteArgs> {
  DirectoriesRoute({
    Key? key,
    required String shareType,
    required String parentId,
  }) : super(
          DirectoriesRoute.name,
          path: ':shareType/:parentId',
          args: DirectoriesRouteArgs(
            key: key,
            shareType: shareType,
            parentId: parentId,
          ),
          rawPathParams: {
            'shareType': shareType,
            'parentId': parentId,
          },
        );

  static const String name = 'DirectoriesRoute';
}

class DirectoriesRouteArgs {
  const DirectoriesRouteArgs({
    this.key,
    required this.shareType,
    required this.parentId,
  });

  final Key? key;

  final String shareType;

  final String parentId;

  @override
  String toString() {
    return 'DirectoriesRouteArgs{key: $key, shareType: $shareType, parentId: $parentId}';
  }
}

/// generated route for
/// [AccountPage]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute()
      : super(
          AccountRoute.name,
          path: '',
        );

  static const String name = 'AccountRoute';
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}
