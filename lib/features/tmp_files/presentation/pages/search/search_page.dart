import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/cubit/text_cubit.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/widgets/custom_header_text.dart';

import '../../widgets/custom_bottom_navigator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final textCubit = BlocProvider.of<TextCubit>(context);

    return Scaffold(
      body: _buildBody(textCubit, context),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) =>
            NavigationUtils.onBottomNavigationBarTap(context, index),
      ),
    );
  }

  Widget _buildBody(TextCubit textCubit, BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          buildHeaderText(
            text: 'File Search',
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSearchField(textCubit),
                  ),
                  const SizedBox(width: 10),
                  _buildSearchButton(context, textCubit),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildSearchField(TextCubit textCubit) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff696B7A),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1.5),
            blurRadius: 1,
            color: Colors.grey,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              onChanged: (text) {
                textCubit.setText(text);
              },
              decoration: const InputDecoration(
                hintText: "파일의 ID를 입력하세요.",
                hintStyle: TextStyle(
                  color: Color(0xff282B3B),
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w700,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context, TextCubit textCubit) {
    return Container(
      padding: const EdgeInsets.all(13.5),
      decoration: BoxDecoration(
        color: const Color(0xff696B7A),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        child: const Icon(
          Icons.search_rounded,
          color: Colors.white,
        ),
        onTap: () {
          if (textCubit.state.text.isNotEmpty) {
            _onFolderPressed(context, textCubit.state.text.trim());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('파일 ID를 입력해 주세요.'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
      ),
    );
  }

  void _onFolderPressed(BuildContext context, String folderId) async {
    final result =
        await Navigator.pushNamed(context, '/folder', arguments: folderId);

    if (!mounted) return;
    if (result == null) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$result')));
  }
}
