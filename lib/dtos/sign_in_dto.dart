// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SignInDto extends Equatable {
  const SignInDto({required this.email, required this.password});

  factory SignInDto.initial() => const SignInDto(email: '', password: '');

  final String email;
  final String password;

  SignInDto copyWith({String? email, String? password}) {
    return SignInDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object> get props => [email, password];
}
