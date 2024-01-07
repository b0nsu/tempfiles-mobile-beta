import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/folder.dart';
import '../repositories/repositories.dart';

class GetFolderUseCase implements UseCase<DataState<FolderEntity>, String> {
  final FolderRepository _folderRepository;

  GetFolderUseCase(this._folderRepository);

  @override
  Future<DataState<FolderEntity>> call({String? params}) {
    return _folderRepository.getInfoFolders(
      folderId: params!,
    );
  }
}
