import 'package:auto_route/auto_route.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/core/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final user = await getIt<Fresh<OAuth2Token>>().token;
    if (user == null) {
      await router.pushAndPopUntil(
        const SignInRoute(),
        predicate: (_) => false,
      );
    } else {
      resolver.next();
    }
  }
}
