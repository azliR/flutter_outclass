import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/models/auth/user.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
