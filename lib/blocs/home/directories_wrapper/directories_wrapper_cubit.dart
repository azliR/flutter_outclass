import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/models/directory/post.dart';

part 'directories_wrapper_state.dart';

@injectable
class DirectoriesWrapperCubit extends Cubit<DirectoriesWrapperState> {
  DirectoriesWrapperCubit() : super(DirectoriesWrapperState.initial());

  void setCurrentFolderId(String folderId) {
    emit(state.copyWith(currentFolderId: folderId));
  }

  void setFolderController(
    ShareType shareType,
    PagingController<int, Folder> controller,
  ) {
    emit(
      state.copyWith(
        folderPagingControllers: state.folderPagingControllers
          ..[shareType] = controller,
      ),
    );
  }

  void setPostController(
    ShareType shareType,
    PagingController<int, Post> controller,
  ) {
    emit(
      state.copyWith(
        postPagingControllers: state.postPagingControllers
          ..[shareType] = controller,
      ),
    );
  }
}
