import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/dtos/post_dto.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/repositories/directory_repository.dart';

part 'add_post_state.dart';

@injectable
class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this._directoryRepository) : super(AddPostState.initial());

  final DirectoryRepository _directoryRepository;

  void init({
    required Post? existingPost,
    required ShareType shareType,
    required String? parentId,
    required String? classroomId,
  }) {
    final AddPostDto dto;
    if (existingPost == null) {
      dto = state.addPostDto;
    } else {
      dto = AddPostDto.fromModel(existingPost);
    }

    emit(
      state.copyWith(
        addPostDto: dto.copyWith(
          classroomId: shareType == ShareType.classroom ? classroomId : null,
          parentId: parentId,
        ),
      ),
    );
  }

  void onPostNameChanged(String postName) {
    emit(
      state.copyWith(
        addPostDto: state.addPostDto.copyWith(name: postName),
      ),
    );
  }

  void onPostDescriptionChanged(String postDescription) {
    emit(
      state.copyWith(
        addPostDto: state.addPostDto.copyWith(description: postDescription),
      ),
    );
  }

  void onPostFilesChanged(List<File> postFiles) {
    emit(
      state.copyWith(
        addPostDto: state.addPostDto.copyWith(files: postFiles),
      ),
    );
  }

  Future<void> onSavePressed({
    required bool isUpdating,
    required void Function(Post post) onPostCreated,
  }) async {
    emit(state.copyWith(status: AddPostStatus.submitting));

    final response = isUpdating
        ? await _directoryRepository.updatePost(dto: state.addPostDto)
        : await _directoryRepository.createPost(dto: state.addPostDto);
    if (!response.success) {
      emit(state.copyWith(status: AddPostStatus.failure));
      return;
    }
    emit(state.copyWith(status: AddPostStatus.success));
    onPostCreated(response.data!);
  }
}
