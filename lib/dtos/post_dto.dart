import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:outclass/models/directory/post.dart';

class AddPostDto extends Equatable {
  const AddPostDto({
    this.id,
    this.parentId,
    this.classroomId,
    required this.name,
    this.description,
    required this.files,
  });

  factory AddPostDto.initial() => const AddPostDto(
        name: '',
        files: [],
      );

  final String? id;
  final String? parentId;
  final String? classroomId;
  final String name;
  final String? description;
  final List<File> files;

  factory AddPostDto.fromModel(Post post) => AddPostDto(
        id: post.id,
        parentId: post.parentId,
        classroomId: post.classroomId,
        name: post.name,
        description: post.description,
        files: [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'classroom_id': classroomId,
        'name': name,
        'description': description,
        'files': files,
      };

  AddPostDto copyWith({
    String? id,
    String? parentId,
    String? classroomId,
    String? name,
    String? description,
    List<File>? files,
  }) {
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
