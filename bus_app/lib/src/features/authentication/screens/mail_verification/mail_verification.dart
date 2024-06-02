import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/authentication/controllers/mail_verification_controller.dart';
import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(tEmailVerificationTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tVerificationEmailSent,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: tFormHeight),
            ElevatedButton(
              onPressed: () => controller.sendVerificationEmail(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
                backgroundColor: tPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tButtonRadius),
                ),
              ),
              child: const Text(tResendVerificationEmail),
            ),
            const SizedBox(height: tFormHeight),
            ElevatedButton(
              onPressed: () {
                controller.manuallyCheckEmailVerificationStatus();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
                backgroundColor: tPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tButtonRadius),
                ),
              ),
              child: const Text(tCheckVerificationStatus),
            ),
            const SizedBox(height: tFormHeight),
            ElevatedButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tButtonRadius),
                ),
              ),
              child: Text(tBackToLogin.tr),
            ),
          ],
        ),
      ),
    );
  }
}
