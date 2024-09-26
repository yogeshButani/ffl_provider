import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.keepAlwaysLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'FFL',
            style: TextStyle(
                color: AppColors.color17C6AA,
                fontFamily: AppFonts.poppinsBold,
                fontSize: 60,
                height: 0),
          ),
        ),
      ),
    );
  }
}
