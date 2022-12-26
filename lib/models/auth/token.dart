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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'tokenExpiresIn': tokenExpiresIn,
      'refreshToken': refreshToken,
      'refreshTokenExpiresIn': refreshTokenExpiresIn,
    };
  }

  factory Token.fromMap(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'] as String,
      tokenExpiresIn: DateTime.parse(json['token_expires_in'] as String),
      refreshToken: json['refresh_token'] as String,
      refreshTokenExpiresIn:
          DateTime.parse(json['refresh_token_expires_in'] as String),
    );
  }

  @override
  List<Object> get props =>
      [accessToken, tokenExpiresIn, refreshToken, refreshTokenExpiresIn];
}
