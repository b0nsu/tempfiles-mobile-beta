part of 'upload_file_bloc.dart';

class UploadFileState extends Equatable {
  final FolderEntity? data;
  final DioException? error;
  const UploadFileState({this.data, this.error});

  @override
  List<Object?> get props => [data, error];
}

final class FileUploadInitial extends UploadFileState {}

final class FileUploadDone extends UploadFileState {
  const FileUploadDone(FolderEntity data) : super(data: data);
}

final class FileUploadError extends UploadFileState {
  const FileUploadError(DioException error) : super(error: error);
}

final class FileNotSelected extends UploadFileState {}

class FileUploadLoadInProgress extends UploadFileState {
  final int progress;
  final String? fileName;

  const FileUploadLoadInProgress({this.progress = 0, this.fileName});

  @override
  List<Object?> get props => [progress, fileName];
}
