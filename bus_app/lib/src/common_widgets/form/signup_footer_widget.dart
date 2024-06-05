import 'package:bus_app/src/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart'; // Import the sign_in_button package
import 'package:bus_app/src/constants/text_strings.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: SignInButton(
            Buttons.google,
            onPressed: () {
              // Add your Google sign-in logic here
            },
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: tAlreadyHaveAnAccount,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(text: tLogin.toUpperCase())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
