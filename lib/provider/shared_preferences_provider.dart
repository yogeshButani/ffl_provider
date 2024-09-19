import 'package:fitforalegend_provider/const/app_storage.dart';
import 'package:fitforalegend_provider/const/app_storage_manager.dart';
import 'package:flutter/material.dart';

class SharedPreferencesProvider with ChangeNotifier {
  String? _username;
  String? _userEmail;
  String? _userMobile;
  String? _userGender;
  String? _token;

  SharedPreferencesProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _username = await StorageManager.readData(AppStorage.userName) ?? '';
    _userEmail = await StorageManager.readData(AppStorage.userEmail) ?? '';
    _userMobile = await StorageManager.readData(AppStorage.userMobile) ?? '';
    _userGender = await StorageManager.readData(AppStorage.userGender) ?? '';
    _token = await StorageManager.readData(AppStorage.token) ?? '';
    notifyListeners();
  }

  String? get userName => _username;
  String? get userEmail => _userEmail;
  String? get userMobile => _userMobile;
  String? get userGender => _userGender;
  String? get token => _token;

  Future<void> refreshPreferences() async {
    await _loadPreferences();
  }
}
