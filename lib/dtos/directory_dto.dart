// ignore_for_file: public_member_api_docs, sort_constructors_first

enum ShareType {
  classroom,
  group,
  personal;

  static ShareType fromString(String type) {
    switch (type) {
      case 'class':
        return ShareType.classroom;
      case 'group':
        return ShareType.group;
      case 'personal':
        return ShareType.personal;
      default:
        throw Exception('Invalid share type');
    }
  }

  @override
  String toString() {
    switch (this) {
      case ShareType.classroom:
        return 'class';
      case ShareType.group:
        return 'group';
      case ShareType.personal:
        return 'personal';
    }
  }
}

class GetFoldersDto {
  const GetFoldersDto({
    required this.classroomId,
    required this.shareType,
    required this.parentId,
    required this.page,
    required this.pageLimit,
  });

  static const String type = 'folder';
  final String classroomId;
  final ShareType shareType;
  final String parentId;
  final int page;
  final int pageLimit;

  Map<String, dynamic> toJson() => {
        'type': type,
        'classroom_id': classroomId,
        'share_type': shareType.toString(),
        'parent_id': parentId,
        'page': page,
        'page_limit': pageLimit,
      };
}

class GetPostsDto {
  const GetPostsDto({
    required this.classroomId,
    required this.shareType,
    required this.parentId,
    required this.page,
    required this.pageLimit,
  });

  static const String type = 'post';
  final String classroomId;
  final ShareType shareType;
  final String parentId;
  final int page;
  final int pageLimit;

  Map<String, dynamic> toJson() => {
        'type': type,
        'classroom_id': classroomId,
        'share_type': shareType.toString(),
        'parent_id': parentId,
        'page': page,
        'page_limit': pageLimit,
      };
}
