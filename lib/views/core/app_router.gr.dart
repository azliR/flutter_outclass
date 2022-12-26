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
        child: const CalendarPage(),
      );
    },
    PostsWrapperRoute.name: (routeData) {
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
    PostsRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const PostsPage(),
      );
    },
    AccountRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const AccountPage(),
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
          path: 'in',
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
              PostsWrapperRoute.name,
              path: 'posts',
              parent: HomeWrapperRoute.name,
              children: [
                RouteConfig(
                  PostsRoute.name,
                  path: '',
                  parent: PostsWrapperRoute.name,
                )
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
          path: 'in',
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
class PostsWrapperRoute extends PageRouteInfo<void> {
  const PostsWrapperRoute({List<PageRouteInfo>? children})
      : super(
          PostsWrapperRoute.name,
          path: 'posts',
          initialChildren: children,
        );

  static const String name = 'PostsWrapperRoute';
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
/// [PostsPage]
class PostsRoute extends PageRouteInfo<void> {
  const PostsRoute()
      : super(
          PostsRoute.name,
          path: '',
        );

  static const String name = 'PostsRoute';
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
