import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/models/calendar/event.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class EventRepository {
  EventRepository(this._client);

  final Dio _client;

  Future<HttpResponse<List<Event>>> getEvents(
      {required String classroomId}) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/events/class/$classroomId',
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => (data as List<dynamic>)
            .map((event) => Event.fromJson(event as Map<String, dynamic>))
            .toList(),
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
    }
  }
}
