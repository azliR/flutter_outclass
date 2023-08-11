part of 'account_cubit.dart';

enum FetchProfileStatus { initial, inProgress, succeeded, failed }

class AccountState extends Equatable {
  const AccountState({
    this.profile,
    required this.status,
  });

  factory AccountState.initial() => const AccountState(
        status: FetchProfileStatus.initial,
      );

  final ClassroomMemberProfile? profile;
  final FetchProfileStatus status;

  AccountState copyWith({
    ClassroomMemberProfile? profile,
    FetchProfileStatus? status,
  }) {
    return AccountState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [profile, status];
}
