import 'package:equatable/equatable.dart';

class JoinClassroomDto extends Equatable {
  const JoinClassroomDto({
    required this.classCode,
    required this.studentId,
  });

  factory JoinClassroomDto.initial() => const JoinClassroomDto(
        classCode: '',
        studentId: '',
      );

  final String classCode;
  final String studentId;

  JoinClassroomDto copyWith({
    String? classCode,
    String? studentId,
  }) {
    return JoinClassroomDto(
      classCode: classCode ?? this.classCode,
      studentId: studentId ?? this.studentId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'class_code': classCode,
      'student_id': studentId,
    };
  }

  @override
  List<Object?> get props => [classCode, studentId];
}

class CreateClassroomDto extends Equatable {
  const CreateClassroomDto({
    required this.className,
    required this.classDesc,
    required this.studentId,
  });

  factory CreateClassroomDto.initial() => const CreateClassroomDto(
        className: '',
        classDesc: '',
        studentId: '',
      );

  final String className;
  final String classDesc;
  final String studentId;

  CreateClassroomDto copyWith({
    String? className,
    String? classDesc,
    String? studentId,
  }) {
    return CreateClassroomDto(
      className: className ?? this.className,
      classDesc: classDesc ?? this.classDesc,
      studentId: studentId ?? this.studentId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': className,
      'description': classDesc,
      'student_id': studentId,
    };
  }

  @override
  List<Object?> get props => [className, classDesc, studentId];
}

class GetClassroomsByUserIdDto {
  const GetClassroomsByUserIdDto({
    required this.page,
    required this.pageLimit,
  });

  final int page;
  final int pageLimit;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'page_limit': pageLimit,
    };
  }
}
