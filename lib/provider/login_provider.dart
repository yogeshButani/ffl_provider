import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:fitforalegend_provider/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get email => emailController.text;

  String get password => passwordController.text;

  void onChangeEmail(String value) {
    emailController.text = value;
    notifyListeners();
  }

  void onChangePassword(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  void validate(BuildContext context) {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    if (email.isEmpty) {
      Utility().getToast('Please enter email');
    } else if (password.isEmpty) {
      Utility().getToast('Please enter password');
    } else if (password.length < 6) {
      Utility().getToast('Entered password should be of 6 digit');
    } else {
      onLogin(context);
    }
  }

  onLogin(BuildContext context) {
    Provider.of<SplashProvider>(context,listen: false).setUserLogin(true);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const DashboardScreen(selectedIndex: 0)),
        (route) => false);
  }
}
