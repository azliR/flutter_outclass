import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/models/classroom/classroom_member_profile.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class ClassroomMemberRepository {
  ClassroomMemberRepository(this._client);

  final Dio _client;

  Future<HttpResponse<ClassroomMemberProfile>> getClassroomMemberProfile({
    required String classroomId,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/classrooms/$classroomId/members/profile',
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => ClassroomMemberProfile.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.badResponse) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => null,
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}
