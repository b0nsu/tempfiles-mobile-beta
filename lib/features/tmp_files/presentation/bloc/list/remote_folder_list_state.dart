part of 'remote_folder_list_bloc.dart';

class FolderListState extends Equatable {
  final FolderListDTO? data;
  final DioException? error;

  const FolderListState({this.data, this.error});

  @override
  List<Object?> get props => [data, error];
}

final class RemoteFolderListLoading extends FolderListState {
  const RemoteFolderListLoading();
}

final class RemoteFolderListDone extends FolderListState {
  const RemoteFolderListDone(FolderListDTO list) : super(data: list);
}

final class RemoteFolderListError extends FolderListState {
  const RemoteFolderListError(DioException error) : super(error: error);
}
