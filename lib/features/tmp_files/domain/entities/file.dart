import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final String? fileName;
  final int? fileSize;
  final String? downloadUrl;

  const FileEntity({
    this.fileName,
    this.fileSize,
    this.downloadUrl,
  });

  @override
  List<Object?> get props => [
        fileName,
        fileSize,
        downloadUrl,
      ];
}
