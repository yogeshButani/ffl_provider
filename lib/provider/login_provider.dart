import 'dart:developer';

import 'package:fitforalegend_provider/const/app_storage.dart';
import 'package:fitforalegend_provider/const/app_storage_manager.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:fitforalegend_provider/screens/dashboard_screen.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;


  String? validateInputs() {
    String email = emailController.text.trim();
    String password = passwordController.text;
    if (email.isEmpty) {
      return 'Please enter email';
    } else if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  void validateAndSubmit(BuildContext context) {
    String? validationError = validateInputs();
    if (validationError != null) {
      Utility().getToast(validationError);
    } else {
      login(context);
    }
  }

  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> body = {};
    body = {
      'email_or_phone': emailController.text.toString(),
      'password': passwordController.text.toString(),
      'fcm_token': 'static_fcm',
      'device_id': 'test_123',
      'device_type': 'android',
      'time_zone': 'Asia/Kolkata',
    };
    var jsonResponse = await Api.loginApi(body);
    isLoading = false;
    if (jsonResponse['status'] == true) {
      log('jsonResponse success>>>${jsonResponse.toString()}');
      if (context.mounted) {
        Provider.of<SplashProvider>(context, listen: false).setUserLogin(true);
      }
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const DashboardScreen(selectedIndex: 0)),
            (route) => false);
      }
      StorageManager.saveData(AppStorage.userName,
          '${jsonResponse['data']['first_name']} ${jsonResponse['data']['last_name']}');
      StorageManager.saveData(
          AppStorage.userEmail, jsonResponse['data']['email']);
      StorageManager.saveData(AppStorage.userId, jsonResponse['data']['id']);
      StorageManager.saveData(
          AppStorage.userMobile, jsonResponse['data']['mobile']);
      StorageManager.saveData(
          AppStorage.userGender, jsonResponse['data']['gender']);
      StorageManager.saveData(AppStorage.token, jsonResponse['data']['token']);
    } else {
      isLoading = false;
      log('jsonResponse failed>>>${jsonResponse.toString()}');
    }
    notifyListeners();
  }
}
