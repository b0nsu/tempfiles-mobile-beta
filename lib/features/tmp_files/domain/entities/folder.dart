import 'package:equatable/equatable.dart';

import 'file.dart';

class FolderEntity extends Equatable {
  final bool? isHidden;
  final String? folderId;
  final int? fileCount;
  final int? downloadCount;
  final int? downloadLimit;
  final DateTime? uploadDate;
  final DateTime? expireTime;
  final String? deleteUrl;
  final List<FileEntity>? files;

  const FolderEntity({
    this.isHidden,
    this.folderId,
    this.fileCount,
    this.downloadCount,
    this.downloadLimit,
    this.uploadDate,
    this.expireTime,
    this.deleteUrl,
    this.files,
  });

  @override
  List<Object?> get props {
    return [
      isHidden,
      folderId,
      fileCount,
      downloadCount,
      downloadLimit,
      uploadDate,
      expireTime,
      deleteUrl,
      files
    ];
  }
}
