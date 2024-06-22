import 'package:get/get.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < 5) {
      currentStep.value = step;
    }
  }
}
