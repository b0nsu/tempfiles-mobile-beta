part of 'delete_file_bloc.dart';

sealed class DeleteFileEvent extends Equatable {
  const DeleteFileEvent();
}

class RequestFileDeleteEvent extends DeleteFileEvent {
  final String? folderId;

  const RequestFileDeleteEvent({this.folderId});

  @override
  List<Object?> get props => [folderId];
}
