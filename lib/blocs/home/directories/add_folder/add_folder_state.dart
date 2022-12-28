part of 'add_folder_cubit.dart';

enum AddFolderStatus {
  initial,
  submitting,
  success,
  failure,
}

class AddFolderState extends Equatable {
  const AddFolderState({
    required this.addFolderDto,
    required this.status,
  });

  factory AddFolderState.initial() => AddFolderState(
        addFolderDto: AddFolderDto.initial(),
        status: AddFolderStatus.initial,
      );

  final AddFolderDto addFolderDto;
  final AddFolderStatus status;

  AddFolderState copyWith({
    AddFolderDto? addFolderDto,
    AddFolderStatus? status,
  }) {
    return AddFolderState(
      addFolderDto: addFolderDto ?? this.addFolderDto,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [addFolderDto, status];
}
