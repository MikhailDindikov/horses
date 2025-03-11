import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/screens/checklist_screen.dart';
import 'package:horses/screens/home_screen.dart';
import 'package:horses/screens/instructions_screen.dart';
import 'package:horses/screens/settings_screen.dart';
import 'package:horses/screens/visual_aids_screen.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _selectedScreen = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          index: _selectedScreen.value,
          children: [
            const HomeScreen(),
            const ChecklistScreen(),
            const VisualAidsScreen(),
            const InstructionsScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration:  BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
            ),
          ],
        ),
        child: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              _selectedScreen.value = value;
            },
            currentIndex: _selectedScreen.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: const Color.fromRGBO(249, 249, 249, 0.9),
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  AppIcons.home,
                ),
                activeIcon: Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainYellow,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.home,
                    color: Colors.white,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  AppIcons.checklist,
                ),
                activeIcon: Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainYellow,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.checklist,
                    color: Colors.white,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  AppIcons.visualAids,
                ),
                activeIcon: Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainYellow,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.visualAids,
                    color: Colors.white,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  AppIcons.instructions,
                ),
                activeIcon: Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainYellow,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.instructions,
                    color: Colors.white,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  AppIcons.settings,
                ),
                activeIcon: Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainYellow,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.settings,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
