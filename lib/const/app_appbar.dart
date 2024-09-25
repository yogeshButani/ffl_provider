import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundcolor;
  final double? toolbarheight;
  final bool automaticallyImplyLeading;
  final TextStyle? titleTextStyle;
  final VoidCallback? onBackTap;
  final Widget? leading;
  final Widget? action;

  const MyAppbar(
      {super.key,
      this.title,
      this.backgroundcolor,
      this.titleTextStyle,
      this.toolbarheight,
      this.onBackTap,
      this.leading,
      this.action,
      this.automaticallyImplyLeading = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundcolor ?? AppColors.backgroundColor,
      toolbarHeight: toolbarheight ?? 73,
      actions: [action ?? const SizedBox.shrink()],
      leading: leading ??
          Visibility(
            visible: automaticallyImplyLeading,
            replacement: const SizedBox.shrink(),
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Material(
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  splashColor: AppColors.color17C6AA.withOpacity(0.7),
                  splashFactory: InkRipple.splashFactory,
                  onTap: onBackTap ??
                      () =>
                          Future.delayed(const Duration(milliseconds: 180), () {
                            Navigator.pop(context);
                          }),
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 35,
                    child: SvgPicture.asset(
                      'assets/images/ic_back_button.svg',
                      height: 35,
                      width: 35,
                    ),
                  ),
                ),
              ),
            ),
          ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(title ?? "",
          style: titleTextStyle ??
              const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.poppinsSemiBold,
                  color: AppColors.colorBlack)),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
