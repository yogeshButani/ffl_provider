import 'dart:io';

import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  static progressLoadingDialog(BuildContext context, bool status) {
    if (status) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(child: Image.asset('assets/images/gif_loader.gif'));
          });
      // return pr.show();
    } else {
      Navigator.pop(context);
      // return pr.hide();
    }
  }

  Future<bool> isInternetConnected() async {
    bool isConnected = await InternetConnection().hasInternetAccess;
    if (!isConnected) {
      Utility().getToast('No Internet');
    }
    return isConnected;
  }

  Future<File?> getImageFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      if (context.mounted) {
        Utility().getToast("Please select an image for editing");
      }
    }

    return image;
  }

  getToast(msg) {
    Fluttertoast.showToast(
      backgroundColor: AppColors.colorBlack,
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
    );
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(AppStorage.token) ?? '';
    return token;
  }
}
