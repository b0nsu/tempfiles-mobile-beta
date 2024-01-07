import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/data/models/params/file_download_params.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/delete/delete_file_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/download/download_file_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../data/models/dto/folder_dto.dart';
import '../../../domain/entities/file.dart';

import '../../bloc/remote/remote_files_bloc.dart';
import '../../../../../core/utils/file_size_fomatter.dart';

class DetailPage extends StatelessWidget {
  final String? folderId;

  const DetailPage({Key? key, this.folderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MultiBlocListener(
          listeners: [
            BlocListener<DownloadFileBloc, DownloadFileState>(
              listener: (context, state) {
                if (state.status == RemoteStateStatus.success) {
                  _showSnackbar(context, '${state.data} 다운 완료');
                } else if (state is FileDownloadLoadInProgress) {
                } else if (state.status == RemoteStateStatus.error) {
                  _showSnackbar(context, '${state.error}');
                }
              },
            ),
            BlocListener<DeleteFileBloc, DeleteFileState>(
              listener: (context, state) {
                if (state.status == RemoteStateStatus.success) {
                  Navigator.pop(context, '$folderId 삭제 되었습니다.');
                } else if (state.status == RemoteStateStatus.error) {
                  Navigator.pop(context, '${state.error}');
                }
              },
            ),
          ],
          child: BlocBuilder<RemoteFilesBloc, RemoteFilesState>(
            builder: (_, state) {
              if (state.status == RemoteStateStatus.unknown) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status == RemoteStateStatus.error) {
                return _buildErrorWidget("파일을 찾을 수 없습니다.");
              } else if (state.status == RemoteStateStatus.success) {
                return _buildFolderItem(state.data! as FolderDTO, context);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: _textStyle(),
      ),
    );
  }

  Widget _buildFolderItem(FolderDTO folder, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildInfoContainer(folder),
            _buildFileCountText(folder),
          ],
        ),
        const SizedBox(height: 15),
        _buildFileList(folder),
        const SizedBox(height: 30),
        _buildRemainingText(folder),
        const SizedBox(height: 30),
        _buildActionButtons(folder, context),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildInfoContainer(FolderDTO folder) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xff373d4a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${folder.isHidden! ? "비공개 파일" : "공개 파일"} / ${folder.folderId!}',
        style: _textStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildFileCountText(FolderDTO folder) {
    return Text(
      '${folder.fileCount.toString()}개의 파일',
      style: _textStyle(
          color: const Color(0xff8f95e0),
          fontSize: 20,
          fontWeight: FontWeight.w700),
    );
  }

  Widget _buildFileList(FolderDTO folder) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            _buildFileListItem(folder.files![index]),
        itemCount: folder.files!.length,
      ),
    );
  }

  Widget _buildFileListItem(FileEntity file) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xff373d4a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          '${file.fileName}',
          style: _textStyle(
            color: const Color(0xff718DC9),
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          '${file.downloadUrl}',
          style: _textStyle(
            color: const Color(0xff718DC9).withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: BlocBuilder<DownloadFileBloc, DownloadFileState>(
          builder: (context, downloadState) {
            if (downloadState is FileDownloadLoadInProgress &&
                downloadState.fileName == file.fileName) {
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 50),
                builder: (context, value, _) {
                  return CircularProgressIndicator(
                    value: downloadState.progress.toDouble() / 100,
                  );
                },
              );
            } else {
              return Text(
                '${file.fileSize?.toHumanReadableFileSize(round: 1)}',
                style: _textStyle(
                  color: const Color(0xff718DC9),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRemainingText(FolderDTO folder) {
    final remainingDuration = folder.expireTime!.difference(DateTime.now());
    final remainingHours = remainingDuration.inHours;
    final remainingMinutes = remainingDuration.inMinutes % 60;
    final remainingDownloads =
        (folder.downloadLimit)! - (folder.downloadCount)!;

    final remainingText = remainingHours > 0
        ? '만료까지 $remainingHours시간 $remainingMinutes분'
        : '만료까지 $remainingMinutes분';

    return Text(
      '$remainingText / $remainingDownloads회 남았습니다.',
      style: _textStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildActionButtons(FolderDTO folder, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('다운로드', const Color(0xff757bab), () async {
          _downloadFiles(context, folder);
        }),
        _buildActionButton('링크 복사', const Color(0xff757bab), () {
          Clipboard.setData(
              ClipboardData(text: '$tmpfBaseURL/dl/${folderId ?? ''}'));
          _showSnackbar(context, '클립보드에 복사되었어요.');
        }),
        _buildActionButton('폴더 삭제', const Color(0xffaa75ab), () async {
          BlocProvider.of<DeleteFileBloc>(context).add(
            RequestFileDeleteEvent(folderId: folder.folderId!),
          );
        }),
      ],
    );
  }

  Widget _buildActionButton(
      String label, Color buttonColor, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(105, 50),
        elevation: 2,
        padding: const EdgeInsets.all(12),
        backgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: _textStyle(),
      ),
    );
  }

  TextStyle _textStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      color: color ?? Colors.white,
      fontSize: fontSize ?? 18,
      fontFamily: 'NotoSansKR',
      fontWeight: fontWeight ?? FontWeight.w500,
      overflow: overflow ?? TextOverflow.visible,
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _downloadFiles(BuildContext context, FolderDTO folder) {
    for (var file in folder.files!) {
      BlocProvider.of<DownloadFileBloc>(context).add(
        RequestFileDownloadEvent(
          fileDownloadParams: FileDownloadParams(
            folderId: folder.folderId,
            fileName: file.fileName,
          ),
        ),
      );
    }
  }
}
