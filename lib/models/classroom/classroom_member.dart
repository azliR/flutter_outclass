import 'package:equatable/equatable.dart';

class ClassroomMember extends Equatable {
  const ClassroomMember({
    required this.id,
    required this.userId,
    required this.classroomId,
    required this.studentId,
    required this.classroomName,
    required this.name,
    required this.role,
  });

  final String id;
  final String userId;
  final String classroomId;
  final String studentId;
  final String classroomName;
  final String name;
  final int role;

  factory ClassroomMember.fromJson(Map<String, dynamic> json) {
    return ClassroomMember(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      classroomId: json['classroom_id'] as String,
      studentId: json['student_id'] as String,
      classroomName: json['classroom_name'] as String,
      name: json['name'] as String,
      role: json['role'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'classroom_id': classroomId,
        'student_id': studentId,
        'classroom_name': classroomName,
        'name': name,
        'role': role,
      };

  @override
  List<Object> get props {
    return [
      id,
      userId,
      classroomId,
      studentId,
      classroomName,
      name,
      role,
    ];
  }
}
