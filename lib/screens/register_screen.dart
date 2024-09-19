import 'package:fitforalegend_provider/const/app_button.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Consumer<RegisterProvider>(builder: (context, provider, __) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextFormField(
                  controller: provider.firstNameController,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter First Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: provider.lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter Last Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: provider.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: provider.mobileController,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter Mobile Number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: provider.passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: provider.confirmPasswordController,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter Confirm Password',
                  ),
                ),
              ),
              AppButton(
                  isLoading: provider.isLoading,
                  padding: const EdgeInsets.only(top: 50),
                  onPressed: () => provider.validateAndSubmit(context),
                  name: 'Register')
            ],
          ),
        );
      }),
    );
  }
}
