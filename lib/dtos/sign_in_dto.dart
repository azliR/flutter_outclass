import 'package:equatable/equatable.dart';

class SignInDto extends Equatable {
  const SignInDto({required this.email, required this.password});

  factory SignInDto.initial() => SignInDto(email: '', password: '');

  final String email;
  final String password;

  SignInDto copyWith({String? email, String? password}) {
    return SignInDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}
