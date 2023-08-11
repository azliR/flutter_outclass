part of 'directories_wrapper_cubit.dart';

class DirectoriesWrapperState extends Equatable {
  const DirectoriesWrapperState({
    required this.currentFolderId,
    required this.folderPagingControllers,
    required this.postPagingControllers,
  });

  factory DirectoriesWrapperState.initial() => DirectoriesWrapperState(
        currentFolderId: '',
        folderPagingControllers: {
          for (var shareType in ShareType.values)
            shareType: PagingController<int, Folder>(firstPageKey: 1)
        },
        postPagingControllers: {
          for (var shareType in ShareType.values)
            shareType: PagingController<int, Post>(firstPageKey: 1)
        },
      );

  final String currentFolderId;
  final Map<ShareType, PagingController<int, Folder>> folderPagingControllers;
  final Map<ShareType, PagingController<int, Post>> postPagingControllers;

  DirectoriesWrapperState copyWith({
    String? currentFolderId,
    Map<ShareType, PagingController<int, Folder>>? folderPagingControllers,
    Map<ShareType, PagingController<int, Post>>? postPagingControllers,
  }) {
    return DirectoriesWrapperState(
      currentFolderId: currentFolderId ?? this.currentFolderId,
      folderPagingControllers:
          folderPagingControllers ?? this.folderPagingControllers,
      postPagingControllers:
          postPagingControllers ?? this.postPagingControllers,
    );
  }

  @override
  List<Object?> get props => [
        currentFolderId,
        folderPagingControllers,
        postPagingControllers,
      ];
}
