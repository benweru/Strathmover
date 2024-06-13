import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';
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
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(tDashboardTitle, style: txtTheme.bodyMedium),
              Text(tDashboardHeading, style: txtTheme.headlineMedium),
              const SizedBox(height: tDashboardPadding),

              // Search box
              const SearchWidget(),
              const SizedBox(height: tDashboardPadding),

              // Categories
              Categories(
                list: [
                  ListItem(
                    title: 'Category1',
                    heading: 'Category 1 Heading',
                    subHeading: 'Category 1 SubHeading',
                    onPress: () {},
                  ),
                  ListItem(
                    title: 'Category2',
                    heading: 'Category 2 Heading',
                    subHeading: 'Category 2 SubHeading',
                    onPress: () {},
                  ),
                ],
              ),
              const SizedBox(height: tDashboardPadding),

              // Banners
              const MyBannerRow(),
              const SizedBox(height: tDashboardPadding),

              // Recently Booked Trips
              
            ],
          ),
        ),
      ),
    );
  }
}