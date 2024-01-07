part of 'delete_file_bloc.dart';

class DeleteFileState extends Equatable {
  final RemoteStateStatus? status;

  final String? data;
  final DioException? error;

  const DeleteFileState._({
    this.status,
    this.data,
    this.error,
  });

  const DeleteFileState.success({
    RemoteStateStatus? status,
    String? data,
  }) : this._(
          status: RemoteStateStatus.success,
          data: data,
        );

  const DeleteFileState.error({
    RemoteStateStatus? status,
    DioException? error,
  }) : this._(
          status: RemoteStateStatus.error,
          error: error,
        );

  @override
  List<Object?> get props => [status, data, error];
}
