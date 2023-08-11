part of 'create_classroom_cubit.dart';

class CreateClassroomState extends Equatable {
  const CreateClassroomState({
    required this.dto,
  });

  factory CreateClassroomState.initial() => CreateClassroomState(
        dto: CreateClassroomDto.initial(),
      );

  final CreateClassroomDto dto;

  CreateClassroomState copyWith({
    CreateClassroomDto? dto,
  }) {
    return CreateClassroomState(
      dto: dto ?? this.dto,
    );
  }

  @override
  List<Object> get props => [dto];
}
