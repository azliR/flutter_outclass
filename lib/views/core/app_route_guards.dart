import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // final user = getIt<AuthCubit>().state.user;
    // if (user == null) {
    //   router.pushAndPopUntil(const SignInRoute(), predicate: (_) => false);
    // } else {
    resolver.next();
    // }
  }
}
