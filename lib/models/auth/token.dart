// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Token extends Equatable {
  const Token({
    required this.accessToken,
    required this.tokenExpiresIn,
    required this.refreshToken,
    required this.refreshTokenExpiresIn,
  });

  final String accessToken;
  final DateTime tokenExpiresIn;
  final String refreshToken;
  final DateTime refreshTokenExpiresIn;

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'] as String,
      tokenExpiresIn: DateTime.parse(json['token_expires_in'] as String),
      refreshToken: json['refresh_token'] as String,
      refreshTokenExpiresIn:
          DateTime.parse(json['refresh_token_expires_in'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_expires_in': tokenExpiresIn.toIso8601String(),
      'refresh_token': refreshToken,
      'refresh_token_expires_in': refreshTokenExpiresIn.toIso8601String(),
    };
  }

  @override
  List<Object> get props =>
      [accessToken, tokenExpiresIn, refreshToken, refreshTokenExpiresIn];
}
