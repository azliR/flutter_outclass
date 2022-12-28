import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/dtos/folder_dto.dart';
import 'package:outclass/dtos/post_dto.dart';
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

  Future<HttpResponse<Folder>> createFolder({
    required AddFolderDto dto,
  }) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/directories/folders',
        data: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => Folder.fromJson(data as Map<String, dynamic>),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => Folder.fromJson(data as Map<String, dynamic>),
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }

  Future<HttpResponse<Folder>> updateFolder({
    required AddFolderDto dto,
  }) async {
    try {
      final response = await _client.put<Map<String, dynamic>>(
        '/directories/folders/${dto.id}',
        data: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => Folder.fromJson(data as Map<String, dynamic>),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => Folder.fromJson(data as Map<String, dynamic>),
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }

  Future<HttpResponse<Post>> createPost({
    required AddPostDto dto,
  }) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/directories/posts',
        data: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => Post.fromJson(data as Map<String, dynamic>),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => Post.fromJson(data as Map<String, dynamic>),
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }

  Future<HttpResponse<Post>> updatePost({
    required AddPostDto dto,
  }) async {
    try {
      final response = await _client.put<Map<String, dynamic>>(
        '/directories/posts/${dto.id}',
        data: dto.toJson(),
      );

      return HttpResponse.fromJson(
        response.data,
        (data) => Post.fromJson(data as Map<String, dynamic>),
      );
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return HttpResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
          (data) => Post.fromJson(data as Map<String, dynamic>),
        );
      }
      log(e.toString(), stackTrace: stackTrace);
      return HttpResponse(
        success: false,
        message: e.toString(),
      );
    }
  }

  Future<bool> deleteDirectory(
    String directoryId,
  ) async {
    try {
      final response = await _client.delete<String>(
        '/directories/$directoryId',
      );

      return response.statusCode == 204;
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.response) {
        log(e.response.toString(), stackTrace: stackTrace);
        return false;
      }
      log(e.toString(), stackTrace: stackTrace);
      return false;
    }
  }
}
