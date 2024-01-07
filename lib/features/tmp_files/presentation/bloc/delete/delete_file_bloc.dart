import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../domain/usecases/delete_folder.dart';

part 'delete_file_event.dart';
part 'delete_file_state.dart';

class DeleteFileBloc extends Bloc<DeleteFileEvent, DeleteFileState> {
  final DeleteFolderUseCase _deleteFolderUseCase;
  DeleteFileBloc(this._deleteFolderUseCase) : super(const DeleteFileState._()) {
    on<RequestFileDeleteEvent>((event, emit) async {
      final datastate = await _deleteFolderUseCase(params: event.folderId);

      if (datastate is DataSucces) {
        emit(DeleteFileState.success(
          data: event.folderId,
        ));
      }

      if (datastate is DataFailed) {
        emit(DeleteFileState.error(
          error: datastate.error,
        ));
      }
    });
  }
}
