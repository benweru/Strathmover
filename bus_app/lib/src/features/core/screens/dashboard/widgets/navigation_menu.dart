import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/features/core/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(
      () => Scaffold(
        body: controller.screens[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onTabSelected,
          backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
          selectedItemColor: isDarkMode ? tPrimaryColor : Colors.white,
          unselectedItemColor:
              isDarkMode ? tPrimaryColor.withOpacity(0.7) : Colors.white70,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
