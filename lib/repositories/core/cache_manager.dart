import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as path;

class CacheManager {
  CacheManager(this._client);

  final Dio _client;

  Future<File> getFile(String url) async {
    final cacheDir = await getCacheDirectory();
    final fileId = url.split('/').last;

    final file = File(cacheDir.path + fileId);
    if (file.existsSync()) {
      return file;
    } else {
      return downloadFile(url, fileId);
    }
  }

  Future<bool> isCached(String url) async {
    final cacheDir = await getCacheDirectory();
    final fileId = url.split('/').last;

    final file = File(cacheDir.path + fileId);
    return file.existsSync();
  }

  Future<List<File>> getCachedFiles() async {
    final cacheDir = await getCacheDirectory();
    final files = cacheDir.listSync();
    return files.map((file) => File(file.path)).toList();
  }

  Future<File> downloadFile(String url, String fileId) async {
    final cacheDir = await getCacheDirectory();

    final response = await _client.download(url, cacheDir.path + fileId);
    if (response.statusCode == 200) {
      return File(cacheDir.path + fileId);
    }
    throw Exception('Failed to download file');
  }

  Future<Directory> getCacheDirectory() async {
    final dir = await path.getTemporaryDirectory();
    final cacheDir =
        Directory('${dir.path}/outclass/files-cache/').create(recursive: true);
    return cacheDir;
  }
}
