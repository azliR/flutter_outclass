part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    required this.signInDto,
    required this.showPassword,
  });

  factory SignInState.initial() => SignInState(
        signInDto: SignInDto.initial(),
        showPassword: false,
      );

  final SignInDto signInDto;
  final bool showPassword;

  SignInState copyWith({
    SignInDto? signInDto,
    bool? showPassword,
  }) {
    return SignInState(
      signInDto: signInDto ?? this.signInDto,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<Object> get props => [signInDto, showPassword];
}
