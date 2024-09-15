import 'package:fitforalegend_provider/provider/login_provider.dart';
import 'package:fitforalegend_provider/provider/onboarding_provider.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProviders {
  static MultiProvider getProviders({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        // Add more providers as needed
      ],
      child: child,
    );
  }
}
