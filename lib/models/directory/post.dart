import 'package:equatable/equatable.dart';
import 'package:outclass/models/directory/file.dart';
import 'package:outclass/models/directory/user_with_access.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    this.parentId,
    required this.ownerId,
    this.classroomId,
    required this.name,
    this.description,
    this.files,
    this.sharedWith,
    required this.lastModified,
    required this.dateCreated,
  });

  final String id;
  final String? parentId;
  final String ownerId;
  final String? classroomId;
  final String name;
  final String? description;
  final List<PostFile>? files;
  final List<UserWithAccess>? sharedWith;
  final DateTime lastModified;
  final DateTime dateCreated;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] as String,
        parentId: json['parent_id'] as String?,
        ownerId: json['owner_id'] as String,
        classroomId: json['classroom_id'] as String?,
        name: json['name'] as String,
        description: json['description'] as String?,
        files: (json['files'] as List<dynamic>?)
            ?.map((e) => PostFile.fromJson(e as Map<String, dynamic>))
            .toList(),
        sharedWith: (json['shared_with'] as List<dynamic>?)
            ?.map((e) => UserWithAccess.fromJson(e as Map<String, dynamic>))
            .toList(),
        lastModified: DateTime.parse(json['last_modified'] as String),
        dateCreated: DateTime.parse(json['date_created'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'owner_id': ownerId,
        'classroom_id': classroomId,
        'name': name,
        'description': description,
        'files': files?.map((e) => e.toJson()).toList(),
        'shared_with': sharedWith,
        'last_modified': lastModified.toIso8601String(),
        'date_created': dateCreated.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      parentId,
      ownerId,
      classroomId,
      name,
      description,
      files,
      sharedWith,
      lastModified,
      dateCreated,
    ];
  }
}
