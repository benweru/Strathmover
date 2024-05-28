import 'package:bus_app/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/authentication/controllers/signup_controller.dart';
import 'package:bus_app/src/features/authentication/models/user_model.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.signupFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: Helper.validateEmail,
              ),
              TextFormField(
                controller: controller.password,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.phoneNo,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                        UserModel user = UserModel(
                          email: controller.email.text.trim(),
                          password: controller.password.text.trim(),
                          fullName: controller.fullName.text.trim(),
                          phoneNo: controller.phoneNo.text.trim(),
                        );
                        await controller.createUser(user);
                      },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : Text('Signup'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
