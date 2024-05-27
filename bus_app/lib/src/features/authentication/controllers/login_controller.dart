import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/core/screens/dashboard/dashboard.dart';
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
      try {
        await AuthenticationRepository.instance
            .loginWithEmailAndPassword(email.text, password.text);
        Get.offAll(() => const Dashboard());
      } catch (e) {
        // Handle login errors here
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading.value = false;
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
