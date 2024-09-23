import 'dart:io';

import 'package:fitforalegend_provider/const/app_assets.dart';
import 'package:fitforalegend_provider/const/app_button.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_network_image.dart';
import 'package:fitforalegend_provider/provider/user_profile_provider.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
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
                child: Stack(
                  children: [
                    ClipOval(
                      child: Visibility(
                        visible: provider.file == null,
                        replacement: Image.file(
                          File(provider.file?.path ?? '').absolute,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        child: AppNetworkImage(
                          image:
                              '${ApiServices.imageForProfile}${provider.res.data?.image}',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          errorWidget: Image.asset(AppAssets.dumyUserImage),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 90,
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => provider.pickImage(context),
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: AppColors.color17C6AA,
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: AppColors.colorWhite,
                            ),
                          ),
                        ))
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
                  padding: const EdgeInsets.only(top: 50),
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
