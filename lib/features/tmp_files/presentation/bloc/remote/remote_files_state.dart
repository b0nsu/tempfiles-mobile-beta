part of 'remote_files_bloc.dart';

class RemoteFilesState extends Equatable {
  final RemoteStateStatus? status;

  final FolderEntity? data;
  final DioException? error;

  const RemoteFilesState._({
    this.status,
    this.data,
    this.error,
  });

  const RemoteFilesState.success({
    RemoteStateStatus? status,
    FolderEntity? data,
  }) : this._(status: RemoteStateStatus.success, data: data);

  const RemoteFilesState.error({
    RemoteStateStatus? status,
    DioException? error,
  }) : this._(status: RemoteStateStatus.error, error: error);

  @override
  List<Object?> get props => [status, data, error];
}
