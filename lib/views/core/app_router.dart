import 'package:auto_route/auto_route.dart';
import 'package:outclass/views/core/app_route_guards.dart';
import 'package:outclass/views/core/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/in',
          page: SignInRoute.page,
        ),
        AutoRoute(
          path: '/up',
          page: SignUpRoute.page,
        ),
        AutoRoute(
          path: '/join',
          page: JoinRoute.page,
        ),
        AutoRoute(
          path: '/join/student',
          page: JoinInsertStudentIdRoute.page,
        ),
        AutoRoute(
          path: '/join/create',
          page: CreateClassroomRoute.page,
        ),
        AutoRoute(
          path: '/scan',
          page: ScanRoute.page,
        ),
        AutoRoute(
          initial: true,
          path: '/',
          page: HomeWrapperRoute.page,
          guards: [
            AuthGuard(),
          ],
          children: [
            AutoRoute(
              path: '',
              page: OverviewRoute.page,
            ),
            AutoRoute(
              path: 'calendar',
              page: CalendarRoute.page,
            ),
            AutoRoute(
              path: 'folders',
              page: DirectoriesTabWrapperRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: DirectoriesWrapperRoute.page,
                  children: [
                    AutoRoute(
                      path: '',
                      page: DirectoriesShareTypeWrapperRoute.page,
                      children: [
                        RedirectRoute(path: '', redirectTo: 'class/:parentId'),
                        AutoRoute(
                          path: ':shareType/:parentId',
                          page: DirectoriesRoute.page,
                        ),
                      ],
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'folder/add',
                  fullscreenDialog: true,
                  page: AddFolderDialogRoute.page,
                ),
                AutoRoute(
                  path: 'post/add',
                  fullscreenDialog: true,
                  page: AddPostDialogRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'account',
              page: AccountWrapperRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: AccountRoute.page,
                ),
                AutoRoute(
                  path: 'settings',
                  page: SettingsRoute.page,
                ),
              ],
            ),
          ],
        ),
      ];
}
