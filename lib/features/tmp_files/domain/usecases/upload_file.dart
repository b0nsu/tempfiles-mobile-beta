import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';

import '../../data/models/params/file_upload_params.dart';
import '../repositories/repositories.dart';

class UploadFileUseCase implements UseCase<DataState, FileUploadParams> {
  final FolderRepository _folderRepository;

  UploadFileUseCase(this._folderRepository);

  @override
  Future<DataState> call({FileUploadParams? params}) async {
    return _folderRepository.uploadFile(
      uploadParams: params!,
    );
  }
}
