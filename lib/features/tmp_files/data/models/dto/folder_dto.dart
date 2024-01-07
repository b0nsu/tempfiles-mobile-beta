import '../../../domain/entities/folder.dart';
import 'file_dto.dart';

class FolderDTO extends FolderEntity {
  const FolderDTO({
    bool? isHidden,
    String? folderId,
    int? fileCount,
    int? downloadCount,
    int? downloadLimit,
    DateTime? uploadDate,
    DateTime? expireTime,
    String? deleteUrl,
    List<FileDTO>? files,
  }) : super(
          isHidden: isHidden,
          folderId: folderId,
          fileCount: fileCount,
          downloadCount: downloadCount,
          downloadLimit: downloadLimit,
          uploadDate: uploadDate,
          expireTime: expireTime,
          deleteUrl: deleteUrl,
          files: files,
        );

  factory FolderDTO.fromJson(Map<String, dynamic> map) {
    return FolderDTO(
      isHidden: map['isHidden'],
      folderId: map['folderId'],
      fileCount: map['fileCount'],
      downloadCount: map['downloadCount'],
      downloadLimit: map['downloadLimit'],
      uploadDate: DateTime.parse(map['uploadDate']),
      expireTime: DateTime.parse(map['expireTime']),
      deleteUrl: map['deleteUrl'],
      files: List<FileDTO>.from(
          (map['files'] ?? []).map((e) => FileDTO.fromJson(e))),
    );
  }
}
