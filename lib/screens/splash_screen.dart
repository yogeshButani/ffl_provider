import 'package:fitforalegend_provider/const/app_assets.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.keepAlwaysLogin(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            AppAssets.splashLogo,
            height: 130,
            fit: BoxFit.fitWidth,
            width: size.width,
          ),
        ),
      ),
    );
  }
}
