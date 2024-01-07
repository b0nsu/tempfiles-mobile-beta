part of 'download_file_bloc.dart';

class DownloadFileState extends Equatable {
  final RemoteStateStatus? status;

  final String? data;
  final DioException? error;

  const DownloadFileState._({
    this.status,
    this.data,
    this.error,
  });

  const DownloadFileState.success({
    RemoteStateStatus? status,
    String? data,
  }) : this._(status: RemoteStateStatus.success, data: data);

  const DownloadFileState.loading({
    RemoteStateStatus? status,
    String? data,
  }) : this._(status: RemoteStateStatus.loading, data: data);

  const DownloadFileState.error({
    RemoteStateStatus? status,
    DioException? error,
  }) : this._(status: RemoteStateStatus.error, error: error);

  @override
  List<Object?> get props => [status, data, error];
}

class FileDownloadLoadInProgress extends DownloadFileState {
  final int progress;
  final String? fileName;

  const FileDownloadLoadInProgress({this.progress = 0, this.fileName})
      : super.loading();

  @override
  List<Object?> get props => [progress, fileName];
}
