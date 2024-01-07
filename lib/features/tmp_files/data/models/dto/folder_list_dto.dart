import 'folder_dto.dart';

class FolderListDTO {
  final List<FolderDTO>? list;
  final String? message;

  const FolderListDTO({
    this.list,
    this.message,
  });

  factory FolderListDTO.fromJson(Map<String, dynamic> map) {
    return FolderListDTO(
      list: List<FolderDTO>.from(
          (map['list'] ?? []).map((e) => FolderDTO.fromJson(e))),
      message: map['message'],
    );
  }

  FolderListDTO copyWith({
    List<FolderDTO>? list,
    String? message,
  }) {
    return FolderListDTO(
      list: list ?? this.list,
      message: message ?? this.message,
    );
  }
}
