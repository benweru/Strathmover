import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:bus_app/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var showPassword = false.obs;
  var isFacebookLoading = false.obs;
  var isGoogleLoading = false.obs;

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> login() async {
      if (loginFormKey.currentState!.validate()) {
      isLoading.value = true;
     String? loginError = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      isLoading.value = false;

      if (loginError == null) {
        // Show success message
        Get.snackbar(
          'Success',
          'Login successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Show error message
        Get.snackbar(
          'Login Failed',
          loginError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  

  //Google Log In
  // [GooglesignInAuthentication)
  Future<void> googleSignin() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      isGoogleLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }
}
  