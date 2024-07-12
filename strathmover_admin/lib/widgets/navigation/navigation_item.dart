import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

enum NavigationItem {
  dashboard(iconData: Icons.dashboard_outlined),
  trips(iconData: Icons.directions_bus),
  routes(iconData: Icons.map),
  bookings(iconData: Icons.list_outlined),
  users(iconData: Icons.people)
  ;

  const NavigationItem({required this.iconData});
  final IconData iconData;
  String get label => name.pascalCase;
}

