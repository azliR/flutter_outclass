import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/repositories/directory_repository.dart';

part 'directories_state.dart';

@injectable
class DirectoriesCubit extends Cubit<DirectoriesState> {
  DirectoriesCubit(this._directoryRepository)
      : super(DirectoriesState.initial());

  final DirectoryRepository _directoryRepository;

  Future<List<Folder>> getFolders(GetFoldersDto dto) async {
    final response = await _directoryRepository.getFolders(dto: dto);
    if (!response.success) {
      return [];
    }
    return response.data!;
  }

  Future<List<Post>> getPosts(GetPostsDto dto) async {
    final response = await _directoryRepository.getPosts(dto: dto);
    if (!response.success) {
      return [];
    }
    return response.data!;
  }
}
