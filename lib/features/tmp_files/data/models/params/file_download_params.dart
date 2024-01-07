import 'package:dio/dio.dart';

class FileDownloadParams {
  final String? folderID;
  final String? fileName;
  final ProgressCallback? progressCallback;

  const FileDownloadParams({
    this.folderID,
    this.fileName,
    this.progressCallback,
  });
}
