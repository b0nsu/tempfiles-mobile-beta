part of 'upload_file_bloc.dart';

sealed class UploadFileEvent extends Equatable {
  const UploadFileEvent();

  @override
  List<Object?> get props => [];
}

class RequestUploadFile extends UploadFileEvent {
  final FileUploadParams? fileUploadParams;

  const RequestUploadFile({this.fileUploadParams});

  @override
  List<Object?> get props => [fileUploadParams];
}

class NotifyNotSelectFile extends UploadFileEvent {}

class UploadStatusChanged extends UploadFileEvent {
  final int? progress;

  const UploadStatusChanged({this.progress});

  @override
  List<Object?> get props => [progress];
}
