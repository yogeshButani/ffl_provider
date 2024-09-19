import 'package:flutter/material.dart';

class DashboardBottomBarProvider extends ChangeNotifier {
  int selectedTab = 0;

  int get currentTab => selectedTab;

  void onTap(int index) {
    selectedTab = index;
    notifyListeners();
  }
}
