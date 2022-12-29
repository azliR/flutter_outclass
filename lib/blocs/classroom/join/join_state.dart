part of 'join_cubit.dart';

class JoinState extends Equatable {
  const JoinState({
    required this.joinDto,
  });

  factory JoinState.initial() => JoinState(
        joinDto: JoinClassroomDto.initial(),
      );

  final JoinClassroomDto joinDto;

  JoinState copyWith({
    JoinClassroomDto? joinDto,
  }) {
    return JoinState(
      joinDto: joinDto ?? this.joinDto,
    );
  }

  @override
  List<Object> get props => [joinDto];
}
