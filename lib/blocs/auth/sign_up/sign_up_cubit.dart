import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/sign_up_dto.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());

  void toggleShowPassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(signUpDto: state.signUpDto.copyWith(name: name)));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(signUpDto: state.signUpDto.copyWith(email: email)));
  }

  void onPasswordChanged(String password) {
    emit(
      state.copyWith(signUpDto: state.signUpDto.copyWith(password: password)),
    );
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    emit(
      state.copyWith(
        signUpDto: state.signUpDto.copyWith(confirmPassword: confirmPassword),
      ),
    );
  }
}
