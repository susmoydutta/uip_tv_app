import 'package:flutter/material.dart';
import 'package:uip_tv_app/presentation/ui/download_screen.dart';
import 'package:uip_tv_app/presentation/ui/profile_screen.dart';
import 'package:uip_tv_app/presentation/ui/tv_screen.dart';
import 'package:uip_tv_app/presentation/ui/uip_screen.dart';
import 'package:uip_tv_app/presentation/utils/asset_colors_path.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screen = [
    UipScreen(),
    TvScreen(),
    DownloadScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColorsPath.backgroundColors,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: AssetColorsPath.backgroundShadColors,
            borderRadius: BorderRadius.circular(41.0),
            boxShadow: [
              BoxShadow(
                color: AssetColorsPath.backgroundShadColors,
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavBarItem(Icons.home_filled, 0),
              _buildNavBarItem(Icons.tv_rounded, 1),
              _buildNavBarItem(Icons.download_sharp, 2),
              _buildNavBarItem(Icons.person, 3),
            ],
          ),
        ),
      ),
      body: _screen[_selectedIndex],
    );
  }

  Widget _buildNavBarItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: isSelected
              ? AssetColorsPath.iconColors
              : AssetColorsPath.textSmallColors,
          size: isSelected ? 28.0 : 24.0,
        ),
      ),
    );
  }
}
