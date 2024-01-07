import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/remote/remote_files_bloc.dart';

import '../../features/tmp_files/presentation/pages/detail/detail_page.dart';
import '../../features/tmp_files/presentation/pages/home/home_page.dart';
import '../../features/tmp_files/presentation/pages/list/list_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomePage());

      // case '/search':
      //   return _materialRoute(const SearchPage());

      // case '/upload':
      //   return _materialRoute(const UploadPage());

      case '/more':
        return _materialRoute(const ListPage());

      // case '/folder':
      //   return _materialRoute(
      //       DetailPage(folderId: settings.arguments as String));

      case '/folder':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<RemoteFilesBloc>(context)
              ..add(
                RequestFilesLoadEvent(folderId: settings.arguments as String),
              ),
            child: DetailPage(
              folderId: settings.arguments as String,
            ),
          ),
        );

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
