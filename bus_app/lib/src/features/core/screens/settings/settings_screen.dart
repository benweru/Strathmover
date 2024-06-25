import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bus_app/src/constants/images_strings.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/core/controllers/profile_controller.dart';
import 'package:bus_app/src/features/core/screens/settings/widgets/settings_items.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final box = GetStorage();
  bool isDarkMode = false;
  bool notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    Get.put(ProfileController()).getUserData(); // Fetch user data on initialization

    // Load initial settings
    isDarkMode = box.read('isDarkMode') ?? false;
    notificationsEnabled = box.read('notificationsEnabled') ?? false;
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
      box.write('isDarkMode', isDarkMode);
      Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
      box.write('notificationsEnabled', notificationsEnabled);
      // Add additional logic for enabling/disabling notifications here
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back(); // Implement GetX back function
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      return controller.imageUploading.value
                          ? const CircularProgressIndicator()
                          : CircleAvatar(
                              radius: 35,
                              backgroundImage: networkImage.isNotEmpty
                                  ? NetworkImage(networkImage)
                                  : const AssetImage(tProfileImage) as ImageProvider,
                            );
                    }),
                    const SizedBox(width: 20),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.user.value.fullName.isNotEmpty
                                ? controller.user.value.fullName
                                : tProfileHeading,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Passenger",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",
                icon: Icons.language,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingSwitch(
                title: "Notifications",
                icon: Icons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                value: notificationsEnabled,
                onTap: _toggleNotifications,
              ),
              const SizedBox(height: 20),
              SettingSwitch(
                title: "Dark Mode",
                icon: Icons.brightness_2,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: _toggleDarkMode,
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Help",
                icon: Icons.help,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
