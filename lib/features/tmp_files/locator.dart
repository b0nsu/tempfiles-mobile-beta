import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/delete/delete_file_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/download/download_file_bloc.dart';

import 'data/datasources/tmpf_api_service.dart';
import 'data/repositories/repositories.dart';
import 'domain/repositories/repositories.dart';

import 'domain/usecases/delete_folder.dart';
import 'domain/usecases/download_file.dart';
import 'domain/usecases/get_folder.dart';
import 'domain/usecases/get_folder_list.dart';
import 'presentation/bloc/list/remote_folder_list_bloc.dart';
import 'presentation/bloc/remote/remote_files_bloc.dart';
import 'presentation/cubit/text_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<TmpfApiService>(TmpfApiService(sl()));

  sl.registerSingleton<FolderRepository>(FolderRepositoryImpl(sl()));

  // TextField
  sl.registerFactory(() => TextCubit(sl));

  // // CheckBox
  // sl.registerFactory(() => CheckBoxCubit(sl));

  // // Slider
  // sl.registerFactory(() => SliderCubit(sl));

  // // Time
  // sl.registerFactory(() => ExpireTimeCubit(sl));

  // Folder List
  sl.registerSingleton<GetFolderListUseCase>(GetFolderListUseCase(sl()));
  sl.registerFactory(() => FolderListBloc(sl()));

  // File
  sl.registerSingleton<GetFolderUseCase>(GetFolderUseCase(sl()));
  sl.registerFactory(() => RemoteFilesBloc(sl()));

  // File Download
  sl.registerSingleton<DownloadFileUseCase>(DownloadFileUseCase(sl()));
  sl.registerFactory(() => DownloadFileBloc(sl()));

  // File Delete
  sl.registerSingleton<DeleteFolderUseCase>(DeleteFolderUseCase(sl()));
  sl.registerFactory(() => DeleteFileBloc(sl()));

  // // File Upload
  // sl.registerSingleton<UploadFileUseCase>(UploadFileUseCase(sl()));
  // sl.registerFactory(() => UploadFileBloc(sl()));
}
