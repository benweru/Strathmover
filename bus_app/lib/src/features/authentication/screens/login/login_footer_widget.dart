import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/authentication/controllers/login_controller.dart'; // Import the controller

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: tFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: Obx(() => SignInButton(
            Buttons.google,
            onPressed: () async {
              await controller.signInWithGoogle();
            },
            text: controller.isGoogleLoading.value ? "Signing in..." : tSignInWithGoogle,
          )),
        ),
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: Text.rich(
            TextSpan(
              text: tDontHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
              children: const [
                TextSpan(
                  text: tSignUp,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
