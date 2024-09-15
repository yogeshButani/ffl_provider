import 'package:fitforalegend_provider/models/onboarding_model.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:fitforalegend_provider/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingProvider extends ChangeNotifier {
  List<OnBoardingModel> list = [
    OnBoardingModel(
      title: 'Lorem ipsum dolor',
      image: 'assets/images/img_onboarding1.png',
      // Replace with your image path or URL
      description:
          'Lorem ipsum dolor sit amet consectetur. Amet fermentum vel sit ut venenatis ac faucibus.', // Add a relevant description
    ),
    OnBoardingModel(
      title: 'Lorem ipsum dolor',
      image: 'assets/images/img_onboarding2.png',
      // Replace with your image path or URL
      description:
          'Lorem ipsum dolor sit amet consectetur. Amet fermentum vel sit ut venenatis ac faucibus.', // Add a relevant description
    ),
    OnBoardingModel(
      title: 'Lorem ipsum dolor',
      image: 'assets/images/img_onboarding3.png',
      // Replace with your image path or URL
      description:
          'Lorem ipsum dolor sit amet consectetur. Amet fermentum vel sit ut venenatis ac faucibus.', // Add a relevant description
    ),
  ];

  int onTapIndex = 0;

  int get currentIndex => onTapIndex;

  late PageController pageController;

  void currentPage() {
    pageController = PageController(initialPage: onTapIndex);
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    if (onTapIndex == 2) {
      skipOnBoarding(context);
    }
  }

  void previousPage(BuildContext context) {
    pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void onChangeIndex(int index) {
    onTapIndex = index;
    notifyListeners();
  }

  void skipOnBoarding(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setOnBoarding(true);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    notifyListeners();
  }
}
