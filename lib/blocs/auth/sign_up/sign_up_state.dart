part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.signUpDto,
    required this.showPassword,
  });

  factory SignUpState.initial() => SignUpState(
        signUpDto: SignUpDto.initial(),
        showPassword: false,
      );

  final SignUpDto signUpDto;
  final bool showPassword;

  SignUpState copyWith({
    SignUpDto? signUpDto,
    bool? showPassword,
  }) {
    return SignUpState(
      signUpDto: signUpDto ?? this.signUpDto,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<Object> get props => [signUpDto, showPassword];
}
