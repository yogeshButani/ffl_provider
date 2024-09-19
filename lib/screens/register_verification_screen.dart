import 'package:fitforalegend_provider/const/app_button.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/provider/register_provider.dart';
import 'package:fitforalegend_provider/provider/register_verification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterVerificationScreen extends StatelessWidget {
  const RegisterVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Consumer<RegisterVerificationProvider>(
          builder: (context, provider, __) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextFormField(
                        controller: provider.mobileOtpController,
                        decoration: const InputDecoration(
                            labelText: 'Enter Mobile Otp'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Visibility(
                              visible: provider.mobileEnableResend,
                              replacement: Text(
                                '${provider.mobileOtpSecondsRemaining.toString()}s remaining',
                                style: const TextStyle(
                                    color: AppColors.colorBlack,
                                    fontFamily: AppFonts.poppinsRegular,
                                    fontSize: 12),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<RegisterProvider>(context,
                                          listen: false)
                                      .sendOtpToRegister(context, true);
                                },
                                child: const Text(
                                  'Resend Otp',
                                  style: TextStyle(
                                      color: AppColors.color17C6AA,
                                      fontFamily: AppFonts.poppinsBold,
                                      fontSize: 14),
                                ),
                              )),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => provider.verifyOtp(context),
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                  color: AppColors.color17C6AA,
                                  fontFamily: AppFonts.poppinsBold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              AppButton(
                  buttonColor: provider.isVerified
                      ? AppColors.color17C6AA
                      : AppColors.colorHintText,
                  padding: const EdgeInsets.only(bottom: 40),
                  isLoading: provider.isLoading,
                  onPressed: () => provider.validateOtpAndProceed(context),
                  name: "Register"),
            ],
          ),
        );
      }),
    );
  }
}
