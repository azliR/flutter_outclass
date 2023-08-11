import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/dtos/folder_dto.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/repositories/directory_repository.dart';

part 'add_folder_state.dart';

@injectable
class AddFolderCubit extends Cubit<AddFolderState> {
  AddFolderCubit(this._directoryRepository) : super(AddFolderState.initial());

  final DirectoryRepository _directoryRepository;

  void init({
    required Folder? existingFolder,
    required ShareType shareType,
    required String parentId,
    required String? classroomId,
  }) {
    final AddFolderDto dto;
    if (existingFolder == null) {
      dto = state.addFolderDto;
    } else {
      dto = AddFolderDto.fromModel(existingFolder);
    }

    emit(
      state.copyWith(
        addFolderDto: dto.copyWith(
          classroomId: shareType == ShareType.classroom ? classroomId : null,
          parentId: parentId,
        ),
      ),
    );
  }

  void onFolderNameChanged(String folderName) {
    emit(
      state.copyWith(
        addFolderDto: state.addFolderDto.copyWith(name: folderName),
      ),
    );
  }

  void onFolderColorChanged(String folderColor) {
    emit(
      state.copyWith(
        addFolderDto: state.addFolderDto.copyWith(color: folderColor),
      ),
    );
  }

  void onFolderDescriptionChanged(String folderDescription) {
    emit(
      state.copyWith(
        addFolderDto:
            state.addFolderDto.copyWith(description: folderDescription),
      ),
    );
  }

  Future<void> onSavePressed({
    required bool isUpdating,
    required void Function(Folder folder) onFolderCreated,
  }) async {
    emit(state.copyWith(status: AddFolderStatus.submitting));

    final response = isUpdating
        ? await _directoryRepository.updateFolder(dto: state.addFolderDto)
        : await _directoryRepository.createFolder(dto: state.addFolderDto);
    if (!response.success) {
      emit(state.copyWith(status: AddFolderStatus.failure));
      return;
    }
    emit(state.copyWith(status: AddFolderStatus.success));
    onFolderCreated(response.data!);
  }
}
