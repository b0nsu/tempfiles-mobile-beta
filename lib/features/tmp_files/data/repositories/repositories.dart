import 'dart:io';

import 'package:dio/dio.dart';

import 'package:tempfiles_mobile_beta/features/tmp_files/data/models/dto/folder_list_dto.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/domain/entities/folder.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/tmpf_api_service.dart';
import '../models/params/file_download_params.dart';
import '../models/params/file_upload_params.dart';

class FolderRepositoryImpl implements FolderRepository {
  final TmpfApiService _tmpfApiService;
  FolderRepositoryImpl(this._tmpfApiService);

  @override
  Future<DataState<FolderListDTO>> getInfoFolderList() async {
    try {
      final httpResponse = await _tmpfApiService.getInfoFolderList();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucces(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<FolderEntity>> getInfoFolders({
    String? folderId,
  }) async {
    try {
      final httpResponse = await _tmpfApiService.getInfoFolders(
        folderId: folderId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucces(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> downloadFile({
    FileDownloadParams? downloadParams,
  }) async {
    try {
      final url =
          '$tmpfAPIBaseURL/dl/${downloadParams!.folderID}/${downloadParams.fileName}';
      Directory externalDirectory = Directory('/storage/emulated/0/Download');
      final saveFilePath =
          '${externalDirectory.path}/${downloadParams.fileName}';

      final downloadResponse = await Dio().download(
        url,
        saveFilePath,
        onReceiveProgress: downloadParams.progressCallback,
      );

      if (downloadResponse.statusCode == HttpStatus.ok) {
        return DataSucces(downloadParams.fileName!);
      } else {
        return DataFailed(DioException(
          error: downloadResponse.statusMessage,
          response: downloadResponse,
          type: DioExceptionType.badResponse,
          requestOptions: downloadResponse.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState> deleteFolder({
    String? folderId,
  }) async {
    try {
      final httpResponse = await _tmpfApiService.deleteFolders(
        folderId: folderId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucces(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState> uploadFile({
    FileUploadParams? uploadParams,
  }) async {
    try {
      final httpResponse = await _tmpfApiService.uploadFile(
        isHidden: uploadParams!.isHidden,
        downloadLimit: uploadParams.downloadLimit,
        expireTime: uploadParams.expireTime,
        files: List.generate(
          uploadParams.files!.paths.length,
          (index) => MultipartFile.fromFileSync(
            uploadParams.files!.paths[index]!,
          ),
        ),
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucces(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
