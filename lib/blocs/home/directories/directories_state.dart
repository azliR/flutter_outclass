// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'directories_cubit.dart';

enum DeleteDirectoryStatus {
  initial,
  deleting,
  success,
  failure,
}

class DirectoriesState extends Equatable {
  const DirectoriesState({
    required this.folderStatus,
    required this.postStatus,
  });

  factory DirectoriesState.initial() => const DirectoriesState(
        folderStatus: DeleteDirectoryStatus.initial,
        postStatus: DeleteDirectoryStatus.initial,
      );

  final DeleteDirectoryStatus folderStatus;
  final DeleteDirectoryStatus postStatus;

  DirectoriesState copyWith({
    DeleteDirectoryStatus? folderStatus,
    DeleteDirectoryStatus? postStatus,
  }) {
    return DirectoriesState(
      folderStatus: folderStatus ?? this.folderStatus,
      postStatus: postStatus ?? this.postStatus,
    );
  }

  @override
  List<Object> get props => [folderStatus, postStatus];
}
