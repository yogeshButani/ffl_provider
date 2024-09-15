import 'package:flutter/material.dart';

class DashboardBottomBarProvider extends ChangeNotifier {
  int _selectedTab = 0;

  int get currentTab => _selectedTab;

  void onTap(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}
