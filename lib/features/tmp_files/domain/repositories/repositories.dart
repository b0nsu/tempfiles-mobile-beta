import '../../../../core/resources/data_state.dart';

import '../../data/models/dto/folder_list_dto.dart';
import '../../data/models/params/file_download_params.dart';
import '../../data/models/params/file_upload_params.dart';
import '../entities/folder.dart';

abstract class FolderRepository {
  Future<DataState<FolderListDTO>> getInfoFolderList();

  Future<DataState<FolderEntity>> getInfoFolders({
    String? folderId,
  });

  Future<DataState<String>> downloadFile({
    FileDownloadParams? downloadParams,
  });

  Future<DataState> deleteFolder({
    String? folderId,
  });

  Future<DataState> uploadFile({
    FileUploadParams? uploadParams,
  });
}
