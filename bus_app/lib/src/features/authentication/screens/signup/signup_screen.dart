import 'package:flutter/material.dart';
import 'package:bus_app/src/common_widgets/form/form_header_widget.dart';
import 'package:bus_app/src/constants/images_strings.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                  imageHeight: 0.15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: tFullName,
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: tFormHeight),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: tEmail,
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: tFormHeight),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: tPhoneNumber,
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                      const SizedBox(height: tFormHeight),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: tPassword,
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: tFormHeight),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the sign-up action
                        },
                        child: const Text(tSignUpTitle),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
