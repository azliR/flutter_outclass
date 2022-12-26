import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/sign_in_dto.dart';
import 'package:outclass/models/auth/token.dart';
import 'package:outclass/repositories/auth_repository.dart';
import 'package:outclass/repositories/token_repository.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepository, this._tokenRepository)
      : super(SignInState.initial());

  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

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
    emit(state.copyWith(status: SignInStatus.submissionInProgress));

    final response = await _authRepository.signIn(
      signInDto: state.signInDto,
    );

    if (response.success) {
      final token = Token.fromMap(response.data!);
      _tokenRepository.setToken(token);
      emit(state.copyWith(status: SignInStatus.submissionSuccess));
    } else {
      emit(state.copyWith(status: SignInStatus.submissionFailure));
    }
  }
}
