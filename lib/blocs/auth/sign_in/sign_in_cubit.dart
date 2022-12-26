import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/sign_in_dto.dart';
import 'package:outclass/repositories/auth_repository.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepository) : super(SignInState.initial());

  final AuthRepository _authRepository;

  void toggleShowPassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(signInDto: state.signInDto.copyWith(email: email)));
  }

  void onPasswordChanged(String password) {
    emit(
      state.copyWith(signInDto: state.signInDto.copyWith(password: password)),
    );
  }

  Future<void> onSignInPressed() async {
    await _authRepository.signIn(
      email: state.signInDto.email,
      password: state.signInDto.password,
    );
  }
}
