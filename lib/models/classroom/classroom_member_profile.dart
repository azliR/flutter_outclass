import 'package:equatable/equatable.dart';

class ClassroomMemberProfile extends Equatable {
  const ClassroomMemberProfile({
    required this.id,
    required this.userId,
    required this.classroomId,
    required this.studentId,
    required this.name,
    required this.email,
    required this.role,
    required this.classroomName,
    required this.classCode,
    this.description,
    required this.classMembersCount,
  });

  final String id;
  final String userId;
  final String classroomId;
  final String studentId;
  final String name;
  final String email;
  final int role;
  final String classroomName;
  final String classCode;
  final String? description;
  final int classMembersCount;

  factory ClassroomMemberProfile.fromJson(Map<String, dynamic> json) {
    return ClassroomMemberProfile(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      classroomId: json['classroom_id'] as String,
      studentId: json['student_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as int,
      classroomName: json['classroom_name'] as String,
      classCode: json['class_code'] as String,
      description: json['description'] as String?,
      classMembersCount: json['class_members_count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'classroom_id': classroomId,
        'student_id': studentId,
        'name': name,
        'email': email,
        'role': role,
        'classroom_name': classroomName,
        'class_code': classCode,
        'description': description,
        'class_members_count': classMembersCount,
      };

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      classroomId,
      studentId,
      name,
      email,
      role,
      classroomName,
      classCode,
      description,
      classMembersCount,
    ];
  }
}
