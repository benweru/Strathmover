
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:get/get.dart';

import '../../../common_widgets/form/onboarding_widget.dart';
import '../../../constants/colours.dart';
import '../../../constants/images_strings.dart';

class OnBoardingController extends GetxController{

  final controller = LiquidController();
  RxInt currentPage = 0.obs;


  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage1,
        title: tOnBoardingTitle1,
        subTitle: tOnBoardingSubTitle1,
        counterText: tOnBoardingCounter1,
        bgColor: tOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage2,
        title: tOnBoardingTitle2,
        subTitle: tOnBoardingSubTitle2,
        counterText: tOnBoardingCounter2,
        bgColor: tOnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage3,
        title: tOnBoardingTitle3,
        subTitle: tOnBoardingSubTitle3,
        counterText: tOnBoardingCounter3,
        bgColor: tOnBoardingPage3Color,
      ),
    ),
  ];


  skip() => controller.jumpToPage(page: 2);
  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
  onPageChangedCallback(int activePageIndex) => currentPage.value = activePageIndex;
}