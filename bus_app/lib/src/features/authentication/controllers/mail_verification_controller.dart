  import 'dart:async';
  import 'package:bus_app/src/constants/text_strings.dart';
  import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
  import 'package:bus_app/src/utils/helper.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:get/get_state_manager/src/simple/get_controllers.dart';

  class MailVerificationController extends GetxController {
    late Timer _timer;

    @override
    void onInit() {
      super.onInit();
      sendVerificationEmail();
    }

   /// - Send OR Resend Email Verification
  Future<void> sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }
    /// - Set Timer to check if Verification Completed then Redirect
    void setTimerForAutoRedirect() {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          timer.cancel();
          AuthenticationRepository.instance.setInitialScreen(user);
        }
      });
    }

    /// -- Manually Check if Verification Completed then Redirect
    void manuallyCheckEmailVerificationStatus() {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        AuthenticationRepository.instance.setInitialScreen(user);
      }
    }
  }
