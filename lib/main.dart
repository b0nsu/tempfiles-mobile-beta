import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/locator.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/delete/delete_file_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/download/download_file_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/list/remote_folder_list_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/remote/remote_files_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/cubit/text_cubit.dart';

import 'config/routes/router.dart';
import 'features/tmp_files/presentation/pages/home/home_page.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FolderListBloc>(
          create: (context) => sl()..add(const GetInfoFolderList()),
        ),
        BlocProvider<RemoteFilesBloc>(
          create: (context) => sl<RemoteFilesBloc>(),
        ),
        BlocProvider.value(value: sl<DeleteFileBloc>()),
        BlocProvider.value(value: sl<DownloadFileBloc>()),
        BlocProvider.value(value: sl<TextCubit>()),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff282a3a),
        ),
        home: const HomePage(),
      ),
    );
  }
}
