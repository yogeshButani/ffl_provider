import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final double? textSize;
  final double? borderRadius;
  final double? btnRadius;
  final double? btnWidth;
  final double? btnHeight;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final Color? borderColor;
  final bool? isLoading;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.textStyle,
    this.textSize,
    this.padding,
    this.btnRadius,
    this.borderRadius,
    this.btnWidth,
    this.btnHeight,
    this.buttonColor,
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth ?? MediaQuery.of(context).size.width,
      height: btnHeight,
      margin: padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.buttonColor,
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 25.0)),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.colorWhite,
            backgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent.withOpacity(0.38),
            disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
            shadowColor: Colors.transparent,
            animationDuration: const Duration(milliseconds: 500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
            ),
          ),
          onPressed: (isLoading ?? false) ? null : onPressed,
          child: Visibility(
            visible: isLoading ?? false,
            replacement: Text(
              name,
              style: textStyle ??
                  const TextStyle(
                      fontSize: 15,
                      color: AppColors.colorWhite,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.poppinsBold),
            ),
            child: const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: AppColors.colorWhite,
                  strokeWidth: 3,
                )),
          ),
        ),
      ),
    );
  }
}
