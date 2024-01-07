import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/data/models/dto/folder_list_dto.dart';

import '../../../../../../../core/resources/data_state.dart';
import '../../../domain/usecases/get_folder_list.dart';

part 'remote_folder_list_event.dart';
part 'remote_folder_list_state.dart';

class FolderListBloc extends Bloc<FolderListEvent, FolderListState> {
  final GetFolderListUseCase _getFolderListUseCase;

  FolderListBloc(this._getFolderListUseCase)
      : super(const RemoteFolderListLoading()) {
    on<GetInfoFolderList>((event, emit) async {
      final datastate = await _getFolderListUseCase();

      if (datastate is DataSucces) {
        emit(RemoteFolderListDone(datastate.data!));
      }

      if (datastate is DataFailed) {
        emit(RemoteFolderListError(datastate.error!));
      }
    });

    on<RefreshInfoFolderList>((event, emit) async {
      final newDatastate = await _getFolderListUseCase();

      if (newDatastate is DataSucces) {
        final newDataList = state.data?.copyWith(
          list: newDatastate.data!.list,
          message: newDatastate.data!.message,
        );

        emit(RemoteFolderListDone(newDataList!));
      }

      if (newDatastate is DataFailed) {
        emit(RemoteFolderListError(newDatastate.error!));
      }
    });
  }
}
