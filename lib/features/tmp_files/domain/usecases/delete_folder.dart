import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/repositories.dart';

class DeleteFolderUseCase implements UseCase<DataState, String> {
  final FolderRepository _folderRepository;

  DeleteFolderUseCase(this._folderRepository);

  @override
  Future<DataState> call({String? params}) async {
    return _folderRepository.deleteFolder(
      folderId: params!,
    );
  }
}
