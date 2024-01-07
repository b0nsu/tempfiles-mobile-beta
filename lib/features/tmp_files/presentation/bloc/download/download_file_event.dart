part of 'download_file_bloc.dart';

sealed class DownloadFileEvent extends Equatable {
  const DownloadFileEvent();
}

class RequestFileDownloadEvent extends DownloadFileEvent {
  final FileDownloadParams? fileDownloadParams;

  const RequestFileDownloadEvent({this.fileDownloadParams});

  @override
  List<Object?> get props => [fileDownloadParams];
}

class DownloadStatusChanged extends DownloadFileEvent {
  final int? progress;
  final String? fileName;

  const DownloadStatusChanged({this.progress, this.fileName});

  @override
  List<Object?> get props => [progress, fileName];
}
