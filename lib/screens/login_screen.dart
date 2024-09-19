import 'package:fitforalegend_provider/const/app_button.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/provider/login_provider.dart';
import 'package:fitforalegend_provider/screens/register_screen.dart';
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: provider.passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Please enter password',
                    ),
                  ),
                ),
                AppButton(
                    isLoading: provider.isLoading,
                    padding: const EdgeInsets.only(top: 50),
                    onPressed: () => provider.validateAndSubmit(context),
                    name: 'Login'),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen())),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t Have Any Account,',
                          style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 12,
                              fontFamily: AppFonts.poppinsLight),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                              color: AppColors.color17C6AA,
                              fontSize: 12,
                              fontFamily: AppFonts.poppinsBold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
