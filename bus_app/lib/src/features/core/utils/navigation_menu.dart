import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/features/core/controllers/navigation_controller.dart';
import 'package:bus_app/src/features/core/screens/dashboard/home.dart';
import 'package:bus_app/src/features/core/screens/profile/profile_screen.dart';
import 'package:bus_app/src/features/personalization/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) => controller.selectedIndex.value = index,
          backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
          selectedItemColor: tWhiteColor.withOpacity(0.8),
          unselectedItemColor: tWhiteColor.withOpacity(0.5),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const SettingsScreen()
  ];
}
