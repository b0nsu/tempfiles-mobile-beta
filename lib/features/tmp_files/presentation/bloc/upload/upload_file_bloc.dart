import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/domain/entities/folder.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/params/file_upload_params.dart';
import '../../../domain/usecases/upload_file.dart';

part 'upload_file_event.dart';
part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final UploadFileUseCase _uploadFileUseCase;

  UploadFileBloc(this._uploadFileUseCase) : super(FileUploadInitial()) {
    on<UploadFileEvent>((event, emit) {});

    on<RequestUploadFile>((event, emit) async {
      FilePickerResult? files =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      if (files != null) {
        FilePickerStatus.done;

        final datastate = await _uploadFileUseCase(
          params: FileUploadParams(
            isHidden: event.fileUploadParams!.isHidden,
            downloadLimit: event.fileUploadParams!.downloadLimit,
            expireTime: event.fileUploadParams!.expireTime,
            files: files,
            onSendProgress: (count, total) {
              add(UploadStatusChanged(progress: (count * 100 ~/ total)));
            },
          ),
        );

        if (datastate is DataSucces) {
          emit(FileUploadDone(datastate.data!));
        }

        if (datastate is DataFailed) {
          emit(FileUploadError(datastate.error!));
        }
      } else {
        add(NotifyNotSelectFile());
      }
    });

    on<NotifyNotSelectFile>((event, emit) {
      emit(FileNotSelected());
    });

    on<UploadStatusChanged>((event, emit) async {
      if (event.progress != 100) {
        emit(FileUploadLoadInProgress(progress: event.progress!));
      }
    }, transformer: sequential());
  }
}
