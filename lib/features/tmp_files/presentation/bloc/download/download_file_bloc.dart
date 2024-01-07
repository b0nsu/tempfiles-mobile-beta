import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../data/models/params/file_download_params.dart';
import '../../../domain/usecases/download_file.dart';

part 'download_file_event.dart';
part 'download_file_state.dart';

class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {
  final DownloadFileUseCase _downloadFileUseCase;
  DownloadFileBloc(this._downloadFileUseCase)
      : super(const DownloadFileState._()) {
    on<RequestFileDownloadEvent>(
      (event, emit) async {
        final datastate = await _downloadFileUseCase(
            params: FileDownloadParams(
          folderID: event.fileDownloadParams!.folderID,
          fileName: event.fileDownloadParams!.fileName,
          progressCallback: (count, total) {
            add(DownloadStatusChanged(
              progress: (count * 100 ~/ total),
              fileName: event.fileDownloadParams!.fileName,
            ));
          },
        ));

        if (datastate is DataSucces) {
          emit(DownloadFileState.success(
            data: datastate.data,
          ));
        }

        if (datastate is DataFailed) {
          emit(DownloadFileState.error(
            error: datastate.error,
          ));
        }
      },
      transformer: sequential(),
    );

    on<DownloadStatusChanged>((event, emit) async {
      if (event.progress == 100) {
        emit(DownloadFileState.success(data: event.fileName));
      } else {
        Future.delayed(const Duration(milliseconds: 50));
        emit(FileDownloadLoadInProgress(
            progress: event.progress!, fileName: event.fileName));
      }
    }, transformer: sequential());
  }
}
