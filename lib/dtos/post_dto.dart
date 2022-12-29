import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:outclass/models/directory/post.dart';

class AddPostDto extends Equatable {
  const AddPostDto({
    this.id,
    required this.parentId,
    required this.classroomId,
    required this.name,
    required this.description,
    required this.files,
  });

  factory AddPostDto.initial() => const AddPostDto(
        parentId: '',
        classroomId: '',
        name: '',
        description: '',
        files: [],
      );

  final String? id;
  final String parentId;
  final String classroomId;
  final String name;
  final String description;
  final List<XFile> files;

  factory AddPostDto.fromModel(Post post) => AddPostDto(
        id: post.id,
        parentId: post.parentId ?? '',
        classroomId: post.classroomId ?? '',
        name: post.name,
        description: post.description ?? '',
        files: const [],
      );

  Future<Map<String, dynamic>> toJson() async => {
        'id': id,
        'parent_id': parentId,
        'classroom_id': classroomId,
        'name': name,
        'description': description,
        'files': await Future.wait(
          files
              .map(
                (file) => MultipartFile.fromFile(
                  file.path,
                  filename: file.name,
                ),
              )
              .toList(),
        ),
      };

  AddPostDto copyWith({
    String? id,
    String? parentId,
    String? classroomId,
    String? name,
    String? description,
    List<XFile>? files,
  }) {
    print('parentId: ${this.parentId}');
    print('description: ${this.description}');
    return AddPostDto(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      classroomId: classroomId ?? this.classroomId,
      name: name ?? this.name,
      description: description ?? this.description,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      parentId,
      classroomId,
      name,
      description,
      files,
    ];
  }
}
