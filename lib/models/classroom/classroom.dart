import 'package:equatable/equatable.dart';

class Classroom extends Equatable {
  const Classroom({
    required this.id,
    required this.name,
    required this.classCode,
    this.description,
  });

  final String id;
  final String name;
  final String classCode;
  final String? description;

  factory Classroom.fromJson(Map<String, dynamic> json) => Classroom(
        id: json['id'] as String,
        name: json['name'] as String,
        classCode: json['class_code'] as String,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'class_code': classCode,
        'description': description,
      };

  @override
  List<Object?> get props => [id, name, classCode, description];
}
