part of 'remote_files_bloc.dart';

sealed class RemoteFilesEvent extends Equatable {
  const RemoteFilesEvent();
}

class RequestFilesLoadEvent extends RemoteFilesEvent {
  final String? folderId;

  const RequestFilesLoadEvent({this.folderId});

  @override
  List<Object?> get props => [folderId];
}
