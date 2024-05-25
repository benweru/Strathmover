import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var showPassword = false.obs;
  var isFacebookLoading = false.obs;
  var isGoogleLoading = false.obs;

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> login() async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
