import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/core/controllers/logout_controller.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/appbar.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/banners.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/categories.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/search.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the LogoutController
    final controller = Get.put(LogoutController());

    // Sample data for categories
    final categories = [
      ListItem(
        title: 'A',
        heading: 'Category 1',
        subHeading: 'Description 1',
        onPress: () {},
      ),
      ListItem(
        title: 'B',
        heading: 'Category 2',
        subHeading: 'Description 2',
        onPress: () {},
      ),
      ListItem(
        title: 'C',
        heading: 'Category 3',
        subHeading: 'Description 3',
        onPress: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout logic
              controller.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(tDashboardPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardAppBar(),
              const SizedBox(height: tDashboardPadding),
              const SearchWidget(),
              const SizedBox(height: tDashboardPadding),
              const MyBannerRow(),
              const SizedBox(height: tDashboardPadding),
              Categories(list: categories),
            ],
          ),
        ),
      ),
    );
  }
}
