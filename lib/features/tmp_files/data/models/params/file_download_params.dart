import 'package:dio/dio.dart';

class FileDownloadParams {
  final String? folderId;
  final String? fileName;
  final ProgressCallback? progressCallback;

  const FileDownloadParams({
    this.folderId,
    this.fileName,
    this.progressCallback,
  });
}
