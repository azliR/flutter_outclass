import 'package:auto_route/auto_route.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/core/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) {
    final authCubit = getIt<AuthCubit>()..initialSetup();
    final user = authCubit.state.token;

    if (user == null) {
      router.pushAndPopUntil(
        const SignInRoute(),
        predicate: (_) => false,
      );
      return;
    }

    final classroom = getIt<AuthCubit>().state.classroomMember;
    if (classroom == null) {
      router.pushAndPopUntil(
        const SignInRoute(),
        predicate: (_) => false,
      );
      return;
    }
    resolver.next();
  }
}
