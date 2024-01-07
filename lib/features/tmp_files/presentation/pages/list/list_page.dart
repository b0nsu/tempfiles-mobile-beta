import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/data/models/dto/folder_list_dto.dart';

import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/widgets/custom_header_text.dart';

import '../../../domain/entities/folder.dart';
import '../../bloc/list/remote_folder_list_bloc.dart';
import '../../widgets/custom_bottom_navigator.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) =>
            NavigationUtils.onBottomNavigationBarTap(context, index),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocBuilder<FolderListBloc, FolderListState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (_, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              buildHeaderText(text: 'File List'),
              const SizedBox(height: 10),
              _buildFolderListWidget(_, state),
              const SizedBox(height: 15),
              if (state is RemoteFolderListDone)
                Text(
                  '지금까지 ${state.data!.list!.length}개의 폴더가 공유됐어요.',
                  style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  void _refreshFolderList(BuildContext context) {
    BlocProvider.of<FolderListBloc>(context).add(const RefreshInfoFolderList());
  }

  Widget _buildFolderListWidget(BuildContext context, FolderListState state) {
    if (state is RemoteFolderListLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (state is RemoteFolderListError) {
      return _buildErrorWidget(state.error.toString());
    }

    if (state is RemoteFolderListDone) {
      return _buildFolderList(context, state.data);
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFolderList(BuildContext context, FolderListDTO? data) {
    if (data == null || data.list == null) {
      return const SizedBox.shrink();
    }

    if (data.list!.isEmpty) {
      return _buildNoFilesUploadedWidget(context);
    }

    return _buildFolderListView(context, data.list!);
  }

  Widget _buildNoFilesUploadedWidget(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: ElevatedButton.icon(
          onPressed: () async {
            _refreshFolderList(context);
          },
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color(0xff60626E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: Text(
            '업로드된 파일이 없습니다.',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade300,
            ),
          ),
          label: Icon(
            Icons.refresh_rounded,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildFolderListView(
      BuildContext context, List<FolderEntity> folderList) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          _refreshFolderList(context);
        },
        child: ListView.separated(
          itemCount: folderList.length,
          itemBuilder: (context, index) =>
              _buildFolderItem(context, folderList[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
        ),
      ),
    );
  }

  Widget _buildFolderItem(BuildContext context, FolderEntity folder) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFolderIdContainer(context, folder.folderId!),
        _buildFileCountText(folder.fileCount!),
      ],
    );
  }

  Widget _buildFolderIdContainer(BuildContext context, String folderId) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff373d4a),
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: () => _onFolderPressed(context, folderId),
        child: Text(
          folderId,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _onFolderPressed(BuildContext context, String folderId) async {
    final result =
        await Navigator.pushNamed(context, '/folder', arguments: folderId);

    if (!mounted) return;
    if (result == null) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$result')));

    BlocProvider.of<FolderListBloc>(context).add(const GetInfoFolderList());
  }

  Widget _buildFileCountText(int fileCount) {
    return Text(
      '$fileCount개의 파일',
      style: const TextStyle(
        color: Color(0xff8f95e0),
        fontSize: 20,
        fontFamily: 'NotoSansKR',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
