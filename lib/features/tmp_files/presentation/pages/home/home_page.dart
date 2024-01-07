import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currentIndex = 0;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          _buildSubTitle(),
          const SizedBox(height: 15),
          _buildPoweredByText(),
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    return const Text(
      '간단한 파일 공유 서비스',
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'NotoSansKR',
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'TEMPFILES',
      style: TextStyle(
        fontSize: 46,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    );
  }

  Widget _buildPoweredByText() {
    return const Text(
      'Powerd by tmpf.me',
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: Colors.white54,
      ),
    );
  }
}
