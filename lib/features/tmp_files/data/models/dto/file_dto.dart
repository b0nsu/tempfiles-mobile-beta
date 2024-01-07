import '../../../domain/entities/file.dart';

class FileDTO extends FileEntity {
  const FileDTO({
    String? fileName,
    int? fileSize,
    String? downloadUrl,
  }) : super(
          fileName: fileName,
          fileSize: fileSize,
          downloadUrl: downloadUrl,
        );

  factory FileDTO.fromJson(Map<String, dynamic> map) {
    return FileDTO(
      fileName: map['fileName'],
      fileSize: map['fileSize'],
      downloadUrl: map['downloadUrl'],
    );
  }
}
