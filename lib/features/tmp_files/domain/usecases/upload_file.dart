import 'package:tempfiles_mobile_beta/features/tmp_files/domain/entities/folder.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';

import '../../data/models/params/file_upload_params.dart';
import '../repositories/repositories.dart';

class UploadFileUseCase
    implements UseCase<DataState<FolderEntity>, FileUploadParams> {
  final FolderRepository _folderRepository;

  UploadFileUseCase(this._folderRepository);

  @override
  Future<DataState<FolderEntity>> call({FileUploadParams? params}) async {
    return _folderRepository.uploadFile(
      uploadParams: params!,
    );
  }
}
