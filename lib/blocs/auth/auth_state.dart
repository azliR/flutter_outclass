// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  submissionInProgress,
  submissionSuccess,
  submissionSuccessWithNoClassroom,
  submissionFailure
}

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.token,
    this.classroom,
  });

  final AuthStatus status;
  final Token? token;
  final Classroom? classroom;

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  factory AuthState.fromJson(Map<String, dynamic> json) => AuthState(
        status: json['status'] as AuthStatus? ?? AuthStatus.initial,
        token: json['token'] == null
            ? null
            : Token.fromJson(json['token'] as Map<String, dynamic>),
        classroom: json['classroom'] == null
            ? null
            : Classroom.fromJson(json['classroom'] as Map<String, dynamic>),
      );

  AuthState copyWith({
    AuthStatus? status,
    Token? token,
    Classroom? classroom,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      classroom: classroom ?? this.classroom,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token?.toJson(),
      'classroom': classroom?.toJson(),
    };
  }

  @override
  List<Object?> get props => [status, token, classroom];
}
