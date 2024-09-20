import 'dart:io';

import 'package:fitforalegend_provider/const/app_button.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Consumer<UserProfileProvider>(builder: (context, provider, __) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () => provider.pickImage(context),
                        child: const Text('Pick Image')),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: provider.file != null,
                      child: Image.file(
                        File(provider.file?.path ?? '').absolute,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: provider.firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: provider.genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
              ),
              AppButton(
                  isLoading: provider.isLoading,
                  padding: const EdgeInsets.only(top: 20),
                  btnHeight: 40,
                  onPressed: () => provider.updateUserProfile(context),
                  name: 'Update Profile'),
            ],
          ),
        );
      }),
    );
  }
}
