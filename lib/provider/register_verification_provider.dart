import 'dart:async';


import 'package:fitforalegend_provider/const/app_storage.dart';
import 'package:fitforalegend_provider/const/app_storage_manager.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/provider/register_provider.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:fitforalegend_provider/screens/dashboard_screen.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterVerificationProvider extends ChangeNotifier {
  final TextEditingController mobileOtpController = TextEditingController();
  bool isVerified = false;
  bool isLoading = false;
  bool mobileEnableResend = false;
  static const int initialOtpSeconds = 30;

  late Timer mobileTimer;
  int mobileOtpSecondsRemaining = initialOtpSeconds;

  RegisterVerificationProvider() {
    startMobileTimer();
  }

  // Utility method to start a generic timer
  void _startGenericTimer({
    required int initialSeconds,
    required Function updateTimer,
    required Function onComplete,
  }) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (initialSeconds > 0) {
        updateTimer();
        notifyListeners();
      } else {
        onComplete();
        timer.cancel();
        notifyListeners();
      }
    });
  }

  // Start mobile OTP timer
  void startMobileTimer() {
    mobileEnableResend = false;
    mobileOtpSecondsRemaining = initialOtpSeconds;
    notifyListeners();

    _startGenericTimer(
      initialSeconds: mobileOtpSecondsRemaining,
      updateTimer: () => mobileOtpSecondsRemaining--,
      onComplete: () => mobileEnableResend = true,
    );
  }

  // Validate and proceed to OTP verification or registration
  void validateOtpAndProceed(BuildContext context) {
    String otp = mobileOtpController.text.trim();

    if (otp.isEmpty) {
      Utility().getToast('Please enter OTP');
    } else if (otp.length < 4) {
      Utility().getToast('OTP must be 4 digits long');
    } else if (!isVerified) {
      Utility().getToast('Please verify OTP');
    } else {
      _registerUser(context);
    }
  }

  // OTP verification API call
  Future<void> verifyOtp(BuildContext context) async {
    final registerProvider = Provider.of<RegisterProvider>(context, listen: false);
    Utility.progressLoadingDialog(context, true);

    Map<String, dynamic> params = {
      'phonecode': '91',
      'mobile': registerProvider.mobileController.text.toString(),
      'otp': mobileOtpController.text.toString(),
    };

    var response = await Api.verifyMobileOtp(params);
    if (context.mounted) Utility.progressLoadingDialog(context, false);

    if (response['status'] == true) {
      isVerified = true;
      Utility().getToast(response['message']);
    } else {
      isVerified = false;
      Utility().getToast(response['message']);
    }

    notifyListeners();
  }

  // Register user API call
  Future<void> _registerUser(BuildContext context) async {
    final registerProvider = Provider.of<RegisterProvider>(context, listen: false);
    isLoading = true;
    notifyListeners();

    Map<String, dynamic> params = {
      'first_name': registerProvider.firstNameController.text.toString(),
      'last_name': registerProvider.lastNameController.text.toString(),
      'email': registerProvider.emailController.text.toString(),
      'country_code': '91',
      'mobile': registerProvider.mobileController.text.toString(),
      'password': registerProvider.confirmPasswordController.text.toString(),
      'fcm_token': 'static_fcm',
      'device_id': 'test123',
      'device_type': 'android',
      'time_zone': 'Asia/Kolkata',
    };

    var response = await Api.registerUser(params);
    isLoading = false;
    notifyListeners();

    if (response['status'] == true) {
      if(context.mounted) {
        _handleSuccessfulRegistration(context, response['data']);
      }
    } else {
      Utility().getToast(response['message']);
    }
  }

  // Handle successful registration
  void _handleSuccessfulRegistration(BuildContext context, Map<String, dynamic> data) {
    Utility().getToast('Registration successful');

    StorageManager.saveData(AppStorage.userName, '${data['first_name']} ${data['last_name']}');
    StorageManager.saveData(AppStorage.userEmail, data['email']);
    StorageManager.saveData(AppStorage.userId, data['id']);
    StorageManager.saveData(AppStorage.userMobile, data['mobile']);
    StorageManager.saveData(AppStorage.userGender, data['gender']);
    StorageManager.saveData(AppStorage.token, data['token']);

    // Navigate to the dashboard and set user as logged in
    if (context.mounted) {
      Provider.of<SplashProvider>(context, listen: false).setUserLogin(true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(selectedIndex: 0),
        ),
            (route) => false,
      );
    }
  }

  @override
  void dispose() {
    mobileOtpController.dispose();
    mobileTimer.cancel();
    super.dispose();
  }
}

