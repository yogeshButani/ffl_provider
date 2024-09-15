import 'package:fitforalegend_provider/const/app_constants.dart';
import 'package:fitforalegend_provider/screens/dashboard_screen.dart';
import 'package:fitforalegend_provider/screens/login_screen.dart';
import 'package:fitforalegend_provider/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  bool _isUserLogin = false;
  bool _isSkip = false;

  bool get userLogin => _isUserLogin;

  bool get isSkip => _isSkip;

  Future<void> keepAlwaysLogin(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _isUserLogin = prefs.getBool(AppConstants.isUserLogin) ?? false;
    _isSkip = prefs.getBool(AppConstants.isSkip) ?? false;

    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        _navigateBasedOnLoginStatus(context);
      }
    });
  }

  void _navigateBasedOnLoginStatus(BuildContext context) {
    if (context.mounted) {
      if (_isUserLogin) {
        _navigateTo(context, const DashboardScreen(selectedIndex: 0));
      } else if (_isSkip) {
        _navigateTo(context, const LoginScreen());
      } else {
        _navigateTo(context, const OnboardingScreen());
      }
    }
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  Future<void> setUserLogin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.isUserLogin, value);
    _isUserLogin = value;
    notifyListeners();
  }

  Future<void> setOnBoarding(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.isSkip, value);
    _isSkip = value;
    notifyListeners();
  }
}
