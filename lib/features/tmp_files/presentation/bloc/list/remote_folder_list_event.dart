part of 'remote_folder_list_bloc.dart';

sealed class FolderListEvent {
  const FolderListEvent();
}

class GetInfoFolderList extends FolderListEvent {
  const GetInfoFolderList();
}

class RefreshInfoFolderList extends FolderListEvent {
  const RefreshInfoFolderList();
}
