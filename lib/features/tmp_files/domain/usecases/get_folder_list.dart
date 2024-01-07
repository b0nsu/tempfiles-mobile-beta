import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/dto/folder_list_dto.dart';
import '../repositories/repositories.dart';

class GetFolderListUseCase implements UseCase<DataState<FolderListDTO>, void> {
  final FolderRepository _folderRepository;

  GetFolderListUseCase(this._folderRepository);

  @override
  Future<DataState<FolderListDTO>> call({void params}) {
    return _folderRepository.getInfoFolderList();
  }
}
