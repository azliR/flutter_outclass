part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
    required this.isLoading,
    this.errorMessage,
    this.infoMessage,
  });

  factory AuthState.initial() => const AuthState(
        isLoading: false,
      );

  factory AuthState.fromJson(Map<String, dynamic> map) {
    final userMap = map['user'] as Map?;

    return AuthState.initial().copyWith(
      user: userMap != null ? User.fromJson(userMap.cast()) : null,
      isSkipped: map['isSkipped'] as bool? ?? false,
    );
  }

  final User? user;
  final bool isLoading;
  final String? errorMessage;
  final String? infoMessage;

  static const _defaultInfoMessage = '';
  static const _defaultErrorMessage = '';

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
    };
  }

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage = _defaultErrorMessage,
    String? infoMessage = _defaultInfoMessage,
    bool? isSkipped,
  }) {
    return AuthState(
      user: user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage == _defaultErrorMessage
          ? this.errorMessage
          : errorMessage,
      infoMessage:
          infoMessage == _defaultInfoMessage ? this.infoMessage : infoMessage,
    );
  }

  @override
  List<Object?> get props {
    return [
      user,
      isLoading,
      errorMessage,
      infoMessage,
    ];
  }
}
