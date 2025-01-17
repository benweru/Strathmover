import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/images_strings.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/controllers/profile_controller.dart';
import 'package:bus_app/src/features/core/screens/profile/feedback__screen.dart';
import 'package:bus_app/src/features/core/screens/profile/transport_history.dart';
import 'package:bus_app/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:bus_app/src/features/core/screens/profile/widgets/profile_menu_widget.dart';
import 'package:bus_app/src/features/core/screens/settings/settings_screen.dart';
import 'package:bus_app/src/features/core/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/text_strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    controller.getUserData(); // Fetch user data on initialization
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: TAppBar(
        title: Text(tProfile, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              /// Profile Picture
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Obx(() {
                          final networkImage =
                              controller.user.value.profilePicture;
                          return controller.imageUploading.value
                              ? const CircularProgressIndicator()
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundImage: networkImage.isNotEmpty
                                      ? NetworkImage(networkImage)
                                      : const AssetImage(tProfileImage)
                                          as ImageProvider,
                                );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                return Text(
                  controller.user.value.fullName.isNotEmpty
                      ? controller.user.value.fullName
                      : tProfileHeading,
                  style: Theme.of(context).textTheme.headlineSmall,
                );
              }),
              Text(tProfileSubHeading,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen(),
                      arguments: controller.user.value),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(tEditProfile,
                      style: TextStyle(color: tDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings",
                  icon: Icons.settings,
                  onPress: () {
                    Get.to(() => const SettingsScreen());
                  }),
              ProfileMenuWidget(
                  title: "Transport History",
                  icon: Icons.account_balance_wallet,
                  onPress: () {
                    Get.to(() => const TransportHistoryScreen());
                  }),
              ProfileMenuWidget(
                  title: "User Feedback",
                  icon: Icons.person_add,
                  onPress: () {
                    Get.to(() => const FeedbackScreen()); // Navigate to feedback screen
                  }),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information",
                  icon: Icons.info_outline,
                  onPress: () {
                    _showInformationDialog(context);
                  }),
              ProfileMenuWidget(
                title: "Logout",
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "LOGOUT",
                    titleStyle: const TextStyle(fontSize: 20),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Are you sure, you want to Logout?"),
                    ),
                    confirm: Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            side: BorderSide.none),
                        child: const Text("Yes"),
                      ),
                    ),
                    cancel: OutlinedButton(
                        onPressed: () => Get.back(), child: const Text("No")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('StrathMover'),
          content: const Text('This app has been provided as is.   All rights belong to Christine & Ben'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }
}
