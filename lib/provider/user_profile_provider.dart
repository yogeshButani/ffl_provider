import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/models/response_get_user_profile.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  GetProfileResponse res = GetProfileResponse();
  bool isLoading = false;

  UserProfileProvider() {
    getUserProfile();
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  Future<void> getUserProfile() async {
    isLoading = true;
    notifyListeners();

    res = await Api.getUserProfile();
    if (res.status == true) {
      setValues();
    } else {}

    isLoading = false;
    notifyListeners();
  }

  setValues() {
    firstNameController.text = res.data?.firstName ?? '';
    genderController.text = res.data?.gender ?? '';
    notifyListeners();
  }

  File? file;

  pickImage(BuildContext context) async {
    file = await Utility().getImageFromGallery(context);
    notifyListeners();
  }

  Future<void> updateUserProfile(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    Map<String, String> params = {
      'first_name': firstNameController.text.toString(),
      'gender': genderController.text.toString(),
    };
    List<MultipartFile> files = [];
    if (file != null && file!.path.isNotEmpty) {
      files.add(
        await MultipartFile.fromFile(
          file?.path ?? '',
          filename: 'image',
          contentType: DioMediaType('image', 'jpeg'),
        ),
      );
    } else {
      debugPrint('File is null or path is empty');
    }
    _showLoadingDialog(context, (progress) {
      // Update the progress here
      _uploadProgress = progress;
      notifyListeners();
    });
    var updateRes = await Api.updateUserProfile(
        body: params, files: files, mapKeyFile: 'image',
      onSendProgress: (sent, total) {
        double progress = sent / total;
        _uploadProgress = progress;
        debugPrint('_uploadProgress>>>>$_uploadProgress');
      },
    );
    if (updateRes['status'] == true) {
      res.data?.firstName = updateRes['data']['first_name'];
      res.data?.lastName = updateRes['data']['last_name'];
      res.data?.email = updateRes['data']['email'];
      res.data?.mobile = updateRes['data']['mobile'];
      res.data?.gender = updateRes['data']['gender'];
      res.data?.image = updateRes['data']['image'];
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      log('updateRes : $updateRes');
    } else {
      isLoading = false;
      log('Failed : $updateRes');
    }
    isLoading = false;
    notifyListeners();
  }
  double _uploadProgress = 0;
  void _showLoadingDialog(BuildContext context, Function(double) onProgressUpdate) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        debugPrint('_uploadProgress### $_uploadProgress');
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Uploading...'),
                  SizedBox(height: 20),
                  LinearProgressIndicator(value: _uploadProgress),
                  SizedBox(height: 10),
                  Text('${(_uploadProgress * 100).toStringAsFixed(0)}%'),
                ],
              );
            },
          ),
        );
      },
    );
  }

}
