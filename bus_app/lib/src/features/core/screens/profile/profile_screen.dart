import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/images_strings.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:bus_app/src/features/core/screens/profile/widgets/profile_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

import '../../../../constants/text_strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(FontAwesomeIcons.arrowLeft), // Replace with Font Awesome icon
        ),
        title: Text(tProfile, style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon), // Replace with Font Awesome icon
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tProfileImage)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: tPrimaryColor,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.pen, // Replace with Font Awesome icon
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(tProfileHeading, style: Theme.of(context).textTheme.headlineSmall),
              Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: FontAwesomeIcons.cog, onPress: () {}), // Replace with Font Awesome icon
              ProfileMenuWidget(title: "Billing Details", icon: FontAwesomeIcons.wallet, onPress: () {}), // Replace with Font Awesome icon
              ProfileMenuWidget(title: "User Management", icon: FontAwesomeIcons.userCheck, onPress: () {}), // Replace with Font Awesome icon
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: FontAwesomeIcons.info, onPress: () {}), // Replace with Font Awesome icon
              ProfileMenuWidget(
                title: "Logout",
                icon: FontAwesomeIcons.signOutAlt, // Replace with Font Awesome icon
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
                        onPressed: () => AuthenticationRepository.instance.logout(),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                        child: const Text("Yes"),
                      ),
                    ),
                    cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
