import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/repositories/core/responses.dart';

@lazySingleton
class DirectoryRepository {
  DirectoryRepository(this._client);

  final Dio _client;

  Future<HttpResponse<List<Folder>>> getFolders({
    required GetFoldersDto dto,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/directories',
        queryParameters: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => (data as List<dynamic>)
            .map((folder) => Folder.fromJson(folder as Map<String, dynamic>))
            .toList(),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => (data as List<dynamic>)
              .map((folder) => Folder.fromJson(folder as Map<String, dynamic>))
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

  Future<HttpResponse<List<Post>>> getPosts({
    required GetPostsDto dto,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/directories',
        queryParameters: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => (data as List<dynamic>)
            .map((post) => Post.fromJson(post as Map<String, dynamic>))
            .toList(),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => (data as List<dynamic>)
              .map((post) => Post.fromJson(post as Map<String, dynamic>))
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
