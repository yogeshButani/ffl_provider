import 'package:fitforalegend_provider/provider/dasboard_bottombar_provider.dart';
import 'package:fitforalegend_provider/provider/login_provider.dart';
import 'package:fitforalegend_provider/provider/onboarding_provider.dart';
import 'package:fitforalegend_provider/provider/register_verification_provider.dart';
import 'package:fitforalegend_provider/provider/shared_preferences_provider.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:fitforalegend_provider/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/register_provider.dart';

class AppProviders {
  static MultiProvider getProviders({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SharedPreferencesProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => RegisterVerificationProvider()),
        ChangeNotifierProvider(create: (_) => DashboardBottomBarProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        // Add more providers as needed
      ],
      child: child,
    );
  }
}
