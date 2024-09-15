import 'package:fitforalegend_provider/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedIndex;

  const DashboardScreen({super.key, required this.selectedIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<SplashProvider>(builder: (context, provider, __) {
          return Text(
              'Dashboard Screen ${provider.isSkip} and ${provider.userLogin}');
        }),
      ),
    );
  }
}
