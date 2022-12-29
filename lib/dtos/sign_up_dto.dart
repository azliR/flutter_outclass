import 'package:equatable/equatable.dart';

class SignUpDto extends Equatable {
  const SignUpDto({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory SignUpDto.initial() => const SignUpDto(
        name: '',
        email: '',
        password: '',
        confirmPassword: '',
      );

  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpDto copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpDto(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object> get props => [name, email, password, confirmPassword];
}
