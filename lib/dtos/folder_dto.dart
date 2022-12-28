import 'package:equatable/equatable.dart';
import 'package:outclass/models/directory/folder.dart';

class AddFolderDto extends Equatable {
  const AddFolderDto({
    this.id,
    this.parentId,
    this.classroomId,
    required this.name,
    required this.color,
    this.description,
  });

  factory AddFolderDto.initial() => const AddFolderDto(
        name: '',
        color: 'grape',
      );

  final String? id;
  final String? parentId;
  final String? classroomId;
  final String name;
  final String color;
  final String? description;

  factory AddFolderDto.fromModel(Folder folder) => AddFolderDto(
        id: folder.id,
        parentId: folder.parentId,
        classroomId: folder.classroomId,
        name: folder.name,
        color: folder.color,
        description: folder.description,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'classroom_id': classroomId,
        'name': name,
        'color': color,
        'description': description,
      };

  AddFolderDto copyWith({
    String? id,
    String? parentId,
    String? classroomId,
    String? name,
    String? color,
    String? description,
  }) {
    return AddFolderDto(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      classroomId: classroomId ?? this.classroomId,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      parentId,
      classroomId,
      name,
      color,
      description,
    ];
  }
}
