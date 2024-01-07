import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:tempfiles_mobile_beta/features/tmp_files/domain/entities/folder.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/resources/data_state.dart';

import '../../../domain/usecases/get_folder.dart';

part 'remote_files_event.dart';
part 'remote_files_state.dart';

class RemoteFilesBloc extends Bloc<RemoteFilesEvent, RemoteFilesState> {
  final GetFolderUseCase _getFolderUseCase;

  RemoteFilesBloc(
    this._getFolderUseCase,
  ) : super(const RemoteFilesState._()) {
    on<RequestFilesLoadEvent>((event, emit) async {
      final datastate = await _getFolderUseCase(params: event.folderId);

      if (datastate is DataSucces) {
        emit(RemoteFilesState.success(
          data: datastate.data,
        ));
      }

      if (datastate is DataFailed) {
        emit(RemoteFilesState.error(
          error: datastate.error,
        ));
      }
    }, transformer: sequential());
  }
}
