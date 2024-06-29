import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/authentication/models/user_model.dart';
import 'package:bus_app/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/images_strings.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final txtTheme = Theme.of(context).textTheme; // Ensure txtTheme is defined
    final UserModel? currentUser = Get.arguments
        as UserModel?; // Assuming you pass UserModel from previous screen
    if (currentUser == null) {
      // If the currentUser is null, display an error message or handle it accordingly
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('User data is not available.'),
        ),
      );
    }
    final TextEditingController fullNameController =
        TextEditingController(text: currentUser.fullName ?? '');
    final TextEditingController emailController =
        TextEditingController(text: currentUser.email ?? '');
    final TextEditingController phoneNoController =
        TextEditingController(text: currentUser.phoneNo ?? '');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(FontAwesomeIcons.arrowLeft),
        ),
        title: Text(tEditProfile,
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  // Controllers
                  final email = TextEditingController(text: userData.email);
                  final password =
                      TextEditingController(text: userData.password);
                  final fullName =
                      TextEditingController(text: userData.fullName);
                  final phoneNo = TextEditingController(text: userData.phoneNo);

                  return Column(
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
                            TextButton(
                              onPressed: () =>
                                  controller.uploadUserProfilePicture(
                                      controller.user.value),
                              child: const Text('Change Profile Picture'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50),

                      // -- Form Fields
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              decoration: const InputDecoration(
                                label: Text(tFullName),
                                prefixIcon: Icon(FontAwesomeIcons.user),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                label: Text(tEmail),
                                prefixIcon: Icon(FontAwesomeIcons.envelope),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              controller: phoneNo,
                              decoration: const InputDecoration(
                                label: Text(tPhoneNumber),
                                prefixIcon: Icon(FontAwesomeIcons.phone),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            Obx(() => TextFormField(
                                  controller: password,
                                  obscureText: !controller.showPassword.value,
                                  decoration: InputDecoration(
                                    label: const Text(tPassword),
                                    prefixIcon: const Icon(
                                        FontAwesomeIcons.fingerprint),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.showPassword.value =
                                            !controller.showPassword.value;
                                      },
                                      icon: Icon(controller.showPassword.value
                                          ? Icons.remove_red_eye_sharp
                                          : Icons.remove_red_eye_outlined),
                                    ),
                                  ),
                                )),
                            const SizedBox(height: tFormHeight),

                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final updatedUser = UserModel(
                                    id: userData.id,
                                    fullName: fullName.text.trim(),
                                    email: email.text.trim(),
                                    phoneNo: phoneNo.text.trim(),
                                    password: password.text
                                        .trim(), // Ensure to update password accordingly if needed
                                    profilePicture: currentUser
                                        .profilePicture, // Use existing profile picture
                                  );
                                  await controller.updateRecord(updatedUser);
                                  Get.snackbar("Success", "Profile updated",
                                      snackPosition: SnackPosition.BOTTOM);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: tPrimaryColor,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(tEditProfile,
                                    style: TextStyle(color: tDarkColor)),
                              ),
                            ),
                            const SizedBox(height: tFormHeight),

                            // -- Created Date and Delete Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    text: tJoined,
                                    style: TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: tJoinedAt,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.redAccent.withOpacity(0.1),
                                    elevation: 0,
                                    foregroundColor: Colors.red,
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                  ),
                                  child: const Text(tDelete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
