part of 'sign_in_cubit.dart';

enum SignInStatus {
  initial,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

class SignInState extends Equatable {
  const SignInState({
    required this.signInDto,
    required this.showPassword,
    required this.status,
  });

  factory SignInState.initial() => SignInState(
        signInDto: SignInDto.initial(),
        showPassword: false,
        status: SignInStatus.initial,
      );

  final SignInDto signInDto;
  final bool showPassword;
  final SignInStatus status;

  SignInState copyWith({
    SignInDto? signInDto,
    bool? showPassword,
    SignInStatus? status,
  }) {
    return SignInState(
      signInDto: signInDto ?? this.signInDto,
      showPassword: showPassword ?? this.showPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [signInDto, showPassword, status];
}
