import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/sign_in_dto.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState.initial());

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
}
