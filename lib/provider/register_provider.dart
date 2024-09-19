import 'dart:developer';

import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/provider/register_verification_provider.dart';
import 'package:fitforalegend_provider/screens/register_verification_screen.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? validateInputs() {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (firstName.isEmpty) {
      return 'Please enter first name';
    } else if (lastName.isEmpty) {
      return 'Please enter last name';
    } else if (email.isEmpty) {
      return 'Please enter email';
    } else if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 6) {
      return 'Password should be at least 6 characters';
    } else if (confirmPassword.isEmpty) {
      return 'Please enter confirm password';
    } else if (password != confirmPassword) {
      return 'Password and confirm password do not match';
    }
    return null;
  }

  void validateAndSubmit(BuildContext context) {
    String? validationError = validateInputs();
    if (validationError != null) {
      Utility().getToast(validationError);
    } else {
      sendOtpToRegister(context);
    }
  }

  Future<void> sendOtpToRegister(BuildContext context,
      [bool isResendOtp = false]) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> params = {};
    params = {
      'phonecode': '91',
      'mobile': mobileController.text.toString(),
      'email': emailController.text.toString(),
    };
    var jsonResponse = await Api.sendOtpToRegister(params);
    isLoading = false;
    if (jsonResponse['status'] == true) {
      log('jsonResponse success>>>${jsonResponse.toString()}');
      Utility().getToast(jsonResponse['message']);

      if (isResendOtp) {
        if (context.mounted) {
              Provider.of<RegisterVerificationProvider>(context, listen: false)
                  .startMobileTimer();
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RegisterVerificationScreen()));
        }
      }
    } else {
      isLoading = false;
      Utility().getToast(jsonResponse['message']);
      log('jsonResponse failed>>>${jsonResponse.toString()}');
    }
    notifyListeners();
  }
}
