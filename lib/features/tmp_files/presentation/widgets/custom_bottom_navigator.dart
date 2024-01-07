import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: const Color(0xff1E1F2A),
        items: _buildBottomBarItems(),
      ),
    );
  }

  List<SalomonBottomBarItem> _buildBottomBarItems() {
    return [
      _buildBottomBarItem(Icons.home, "Home", Colors.blue),
      _buildBottomBarItem(Icons.search, "Search", Colors.green),
      _buildBottomBarItem(Icons.upload_file, "Upload", Colors.orange),
      _buildBottomBarItem(Icons.more_horiz, "More", Colors.purple),
    ];
  }

  SalomonBottomBarItem _buildBottomBarItem(
    IconData icon,
    String title,
    Color selectedColor,
  ) {
    return SalomonBottomBarItem(
      icon: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
      ),
      unselectedColor: Colors.white,
      selectedColor: selectedColor,
    );
  }
}

class NavigationUtils {
  static void onBottomNavigationBarTap(BuildContext context, int index) {
    // Add your navigation logic based on the selected index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;

      case 1:
        Navigator.pushReplacementNamed(context, '/search');
        break;

      case 2:
        Navigator.pushReplacementNamed(context, '/upload');
        break;

      case 3:
        Navigator.pushReplacementNamed(context, '/more');
        break;
    }
  }
}
