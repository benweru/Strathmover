import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/features/core/screens/dashboard/dashboard.dart';
import 'package:bus_app/src/features/core/screens/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController{
  final Rx <int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    Container(color: Colors.purple,),
    ];

}