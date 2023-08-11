import 'package:equatable/equatable.dart';
import 'package:outclass/models/auth/token.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  @override
  List<Object?> get props => [id, name, email];
}

class SignUpResponse extends Equatable {
  const SignUpResponse({
    required this.user,
    required this.token,
  });

  final User user;
  final Token token;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        token: Token.fromJson(json['token'] as Map<String, dynamic>),
      );

  @override
  List<Object?> get props => [user, token];
}
