import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/models/calendar/task.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class TaskRepository {
  TaskRepository(this._client);

  final Dio _client;

  Future<HttpResponse<List<Task>>> getTasks({
    required String classroomId,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/tasks/class/$classroomId',
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => (data as List<dynamic>)
            .map((task) => Task.fromJson(task as Map<String, dynamic>))
            .toList(),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => (data as List<dynamic>)
              .map((task) => Task.fromJson(task as Map<String, dynamic>))
              .toList(),
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}
