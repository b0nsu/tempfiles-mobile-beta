import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/params/file_download_params.dart';
import '../repositories/repositories.dart';

class DownloadFileUseCase
    implements UseCase<DataState<String>, FileDownloadParams> {
  final FolderRepository _folderRepository;

  DownloadFileUseCase(this._folderRepository);

  @override
  Future<DataState<String>> call({FileDownloadParams? params}) async {
    return _folderRepository.downloadFile(
      downloadParams: params!,
    );
  }
}
