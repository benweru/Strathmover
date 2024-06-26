import 'package:bus_app/src/features/core/screens/booking_screen.dart';
import 'package:bus_app/src/features/core/screens/profile/profile_screen.dart';
import 'package:bus_app/src/features/core/screens/routes/routes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/core/screens/dashboard/home.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const RoutesScreen(),
    const BookingScreen(),
    const ProfileScreen(),
    // Add more screens here as needed
  ];

  void onTabSelected(int index) {
    selectedIndex.value = index;
  }
}
