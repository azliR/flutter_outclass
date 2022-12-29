import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/classroom_dto.dart';
import 'package:outclass/models/classroom/classroom.dart';
import 'package:outclass/models/classroom/classroom_member.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class ClassroomRepository {
  ClassroomRepository(this._client);

  final Dio _client;

  Future<HttpResponse<ClassroomMember>> joinClassroom({
    required JoinClassroomDto dto,
  }) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/classrooms/join',
        data: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => ClassroomMember.fromJson(data as Map<String, dynamic>),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
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

  Future<HttpResponse<Classroom>> getClassroomById({
    required String classroomId,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/classrooms/$classroomId',
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => Classroom.fromJson(data as Map<String, dynamic>),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
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

  Future<HttpResponse<List<ClassroomMember>>> getClassroomsByUserId({
    required GetClassroomsByUserIdDto dto,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/user/classrooms',
        queryParameters: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => (data as List<dynamic>)
            .map(
              (classroomMember) => ClassroomMember.fromJson(
                classroomMember as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
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
