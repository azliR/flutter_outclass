import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:outclass/views/auth/sign_in/sign_in_page.dart';
import 'package:outclass/views/core/app_route_guards.dart';
import 'package:outclass/views/home-wrapper/account/account_page.dart';
import 'package:outclass/views/home-wrapper/calendar/calendar_page.dart';
import 'package:outclass/views/home-wrapper/home_wrapper_page.dart';
import 'package:outclass/views/home-wrapper/overview/overview_page.dart';
import 'package:outclass/views/home-wrapper/posts/posts_page.dart';
import 'package:outclass/views/home-wrapper/settings/settings_page.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: 'in',
      page: SignInPage,
    ),
    AutoRoute(
      initial: true,
      path: '/',
      page: HomeWrapperPage,
      guards: [AuthGuard],
      children: [
        AutoRoute(
          path: '',
          page: OverviewPage,
        ),
        AutoRoute(
          path: 'calendar',
          page: CalendarPage,
        ),
        AutoRoute(
          path: 'posts',
          page: EmptyRouterPage,
          name: 'PostsWrapperRoute',
          children: [
            AutoRoute(
              path: '',
              page: PostsPage,
            ),
          ],
        ),
        AutoRoute(
          path: 'account',
          page: EmptyRouterPage,
          name: 'AccountWrapperRoute',
          children: [
            AutoRoute(
              path: '',
              page: AccountPage,
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsPage,
            ),
          ],
        ),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({required super.authGuard});
}
