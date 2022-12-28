part of 'add_post_cubit.dart';

enum AddPostStatus {
  initial,
  submitting,
  success,
  failure,
}

class AddPostState extends Equatable {
  const AddPostState({
    required this.addPostDto,
    required this.status,
  });

  factory AddPostState.initial() => AddPostState(
        addPostDto: AddPostDto.initial(),
        status: AddPostStatus.initial,
      );

  final AddPostDto addPostDto;
  final AddPostStatus status;

  AddPostState copyWith({
    AddPostDto? addPostDto,
    AddPostStatus? status,
  }) {
    return AddPostState(
      addPostDto: addPostDto ?? this.addPostDto,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [addPostDto, status];
}
