import 'package:bus_app/src/common_widgets/form/TPrimaryButton_widget.dart';
import 'package:bus_app/src/utils/helper.dart';
// import 'package:flutter/line_awesome_flutter.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/authentication/controllers/login_controller.dart';
import 'package:bus_app/src/features/authentication/screens/forget_password/forget_password_options/forget_password_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Email Field
            TextFormField(
              validator: Helper.validateEmail,
              controller: controller.email,
              decoration:
                  const InputDecoration(prefixIcon: Icon(LineAwesomeIcons.user), labelText: tEmail, hintText: tEmail),
            ),
            const SizedBox(height: tFormHeight - 20),

            /// -- Password Field
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your password';
                  return null;
                },
                obscureText: controller.showPassword.value ? false : true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  labelText: tPassword,
                  hintText: tPassword,
                  suffixIcon: IconButton(
                    icon: controller.showPassword.value
                        ? const Icon(LineAwesomeIcons.eye)
                        : const Icon(LineAwesomeIcons.eye_slash),
                    onPressed: () => controller.showPassword.value = !controller.showPassword.value,
                  ),
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),

            /// -- FORGET PASSWORD BTN
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => ForgetPasswordScreen.buildShowModalBottomSheet(context),
                child: const Text(tForgetPassword),
              ),
            ),

            /// -- LOGIN BTN
            Obx(
              () => TPrimaryButton(
                isLoading: controller.isLoading.value ? true : false,
                text: tLogin.tr,
                onPressed: controller.isFacebookLoading.value || controller.isGoogleLoading.value
                    ? () {}
                    : controller.isLoading.value
                        ? () {}
                        : () => controller.login(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}