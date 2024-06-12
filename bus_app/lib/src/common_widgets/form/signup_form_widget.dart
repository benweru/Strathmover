import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/authentication/controllers/signup_controller.dart';
import 'package:bus_app/src/features/authentication/models/user_model.dart';
import 'package:bus_app/src/utils/helper.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = controller.signupFormKey;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: formKey,  // Use the local formKey here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text(tEmail), prefixIcon: Icon(Icons.email_outlined)),
              validator: Helper.validateEmail,
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                  label: Text(tPhoneNumber),
                  //prefixText: '+254', // Prefill with +254
                  prefixIcon: Icon(Icons.numbers)),
              validator: Helper.validatePhoneNumber,
            ),
            const SizedBox(height: tFormHeight - 20),
            Obx(() => TextFormField(
              controller: controller.password,
              decoration: InputDecoration(
                label: const Text(tPassword),
                prefixIcon: const Icon(Icons.lock),
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
              obscureText: !controller.showPassword.value,
              validator: Helper.validatePassword,
            )),
            const SizedBox(height: tFormHeight - 20),
            Obx(() => TextFormField(
              controller: controller.confirmpassword,
              decoration: InputDecoration(
                labelText: tConfirmPassword,
                prefixIcon: Icon(Icons.fingerprint),
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
              obscureText: !controller.showPassword.value,
                validator: (value) => Helper.validateConfirmPassword(
                  value,
                  controller.password.text,
                ),
            )),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (formKey.currentState!.validate()) {
                            UserModel user = UserModel(
                              email: controller.email.text.trim(),
                              password: controller.password.text.trim(),
                              fullName: controller.fullName.text.trim(),
                              phoneNo: controller.phoneNo.text.trim(),
                            );
                            await controller.createUser(user);
                          }
                        },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Text(tSignUp.toUpperCase()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
