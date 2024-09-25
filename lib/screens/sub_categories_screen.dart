import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatefulWidget {
  final String categoryId;

  const SubCategoriesScreen({
    super.key,
    required this.categoryId,
  });

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.colorWhite,
    );
  }
}
