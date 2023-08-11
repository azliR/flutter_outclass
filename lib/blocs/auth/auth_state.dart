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
    this.classroomMember,
  });

  final AuthStatus status;
  final Token? token;
  final ClassroomMember? classroomMember;

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  factory AuthState.fromJson(Map<String, dynamic> json) => AuthState(
        status: json['status'] as AuthStatus? ?? AuthStatus.initial,
        token: json['token'] == null
            ? null
            : Token.fromJson(json['token'] as Map<String, dynamic>),
        classroomMember: json['classroom'] == null
            ? null
            : ClassroomMember.fromJson(
                json['classroom'] as Map<String, dynamic>),
      );

  AuthState copyWith({
    AuthStatus? status,
    Token? token,
    ClassroomMember? classroomMember,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      classroomMember: classroomMember ?? this.classroomMember,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token?.toJson(),
      'classroom': classroomMember?.toJson(),
    };
  }

  @override
  List<Object?> get props => [status, token, classroomMember];
}
