import 'package:equatable/equatable.dart';
import 'package:outclass/models/directory/user_with_access.dart';

class Folder extends Equatable {
  const Folder({
    required this.id,
    this.parentId,
    required this.ownerId,
    this.classroomId,
    required this.name,
    required this.color,
    this.description,
    required this.sharedWith,
    required this.lastModified,
    required this.dateCreated,
  });

  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        id: json['id'] as String,
        parentId: json['parent_id'] as String?,
        ownerId: json['owner_id'] as String,
        classroomId: json['classroom_id'] as String?,
        name: json['name'] as String,
        color: json['color'] as String,
        description: json['description'] as String?,
        sharedWith: (json['shared_with'] as List<dynamic>)
            .map((e) => UserWithAccess.fromJson(e as Map<String, dynamic>))
            .toList(),
        lastModified: DateTime.parse(json['last_modified'] as String),
        dateCreated: DateTime.parse(json['date_created'] as String),
      );

  final String id;
  final String? parentId;
  final String ownerId;
  final String? classroomId;
  final String name;
  final String color;
  final String? description;
  final List<UserWithAccess> sharedWith;
  final DateTime lastModified;
  final DateTime dateCreated;

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'owner_id': ownerId,
        'classroom_id': classroomId,
        'name': name,
        'color': color,
        'description': description,
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
      color,
      description,
      sharedWith,
      lastModified,
      dateCreated,
    ];
  }
}
