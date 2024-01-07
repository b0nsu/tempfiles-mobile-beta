import 'package:file_picker/file_picker.dart';

class FileUploadParams {
  final bool? isHidden;
  final int? downloadLimit;
  final int? expireTime;
  final FilePickerResult? files;

  const FileUploadParams({
    this.isHidden,
    this.downloadLimit,
    this.expireTime,
    this.files,
  });
}
