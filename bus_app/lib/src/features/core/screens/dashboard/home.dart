import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/controllers/profile_controller.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/booking_card.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/route_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getUserData().then((user) {
      if (user != null) {
        profileController.user.value = user;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: tDefaultSize * 0.8,
          vertical: tDefaultSize * 1.2,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(() {
                      return Text(
                        'Welcome, ${profileController.user.value.fullName.isNotEmpty
                            ? profileController.user.value.fullName
                            : 'User'}',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onBackground,
                        ),
                      );
                    }),
                    SizedBox(
                      child: Obx(() {
                        return CircleAvatar(
                          radius: 30,
                          backgroundImage: profileController
                                      .user.value.profilePicture.isNotEmpty
                              ? NetworkImage(
                                  profileController.user.value.profilePicture)
                              : AssetImage(
                                  'assets/images/profile/profile-pic.jpg')
                                  as ImageProvider,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: tDashboardPadding),
                const BookingCard(),
                const SizedBox(height: tDashboardPadding),
                Text(
                  'Fave Routes idk man',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: colorScheme.onBackground,
                  ),
                ),
                const Column(
                  children: <Widget>[
                    RouteCard(),
                    RouteCard(),
                    RouteCard(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
