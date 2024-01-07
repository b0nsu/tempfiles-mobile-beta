import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../models/dto/folder_dto.dart';
import '../models/dto/folder_list_dto.dart';

part 'tmpf_api_service.g.dart';

@RestApi(baseUrl: tmpfAPIBaseURL)
abstract class TmpfApiService {
  factory TmpfApiService(Dio dio) = _TmpfApiService;

  @GET('/list')
  Future<HttpResponse<FolderListDTO>> getInfoFolderList();

  @GET('/file/{folderId}')
  Future<HttpResponse<FolderDTO>> getInfoFolders({
    @Path('folderId') String? folderId,
  });

  @DELETE('/del/{folderId}')
  Future<HttpResponse> deleteFolders({
    @Path('folderId') String? folderId,
  });

  @POST('/upload')
  @MultiPart()
  Future<HttpResponse<FolderDTO>> uploadFile({
    @Header('X-Hidden') bool? isHidden,
    @Header('X-Download-Limit') int? downloadLimit,
    @Header('X-Time-Limit') int? expireTime,
    @Part(name: 'file') List<MultipartFile>? files,
    @SendProgress() ProgressCallback? onSendProgress,
  });
}
