// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserWithAccess extends Equatable {
  const UserWithAccess({required this.userId, required this.access});

  factory UserWithAccess.fromJson(Map<String, dynamic> json) => UserWithAccess(
        userId: json['user_id'] as String,
        access: json['access'] as String,
      );

  final String userId;
  final String access;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'access': access,
    };
  }

  @override
  List<Object?> get props => [userId, access];
}
