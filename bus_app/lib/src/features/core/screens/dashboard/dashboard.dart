import 'package:bus_app/src/features/core/screens/dashboard/widgets/navigation_menu.dart';
import 'package:bus_app/src/features/core/utils/home_appbar.dart';
import 'package:bus_app/src/features/core/utils/primary_header_container.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            tPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                ],
              ),
            ),
            // Other content of the Dashboard screen
          ],
        ),
      ),
      bottomNavigationBar: NavigationMenu(), // Add the NavigationMenu here
    );
  }
}