import 'package:fitforalegend_provider/const/app_button.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Consumer<LoginProvider>(builder: (context, provider, __) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: provider.emailController,
                    decoration: const InputDecoration(
                      hintText: 'Please enter email',
                    ),
                    onChanged: (value) => provider.onChangeEmail(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: provider.passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Please enter password',
                    ),
                    onChanged: (value) => provider.onChangePassword(value),
                  ),
                ),
                AppButton(
                    padding: const EdgeInsets.only(top: 50),
                    onPressed: () => provider.validate(context),
                    name: 'Login')
              ],
            ),
          );
        }));
  }
}
