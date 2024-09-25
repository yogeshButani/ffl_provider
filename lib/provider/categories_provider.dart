import 'package:fitforalegend_provider/models/response_categories.dart';
import 'package:fitforalegend_provider/screens/sub_categories_screen.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  CategoryResponse res = CategoryResponse();

  bool isLoading = false;

  onCategoryTap(BuildContext context, String categoryId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SubCategoriesScreen(
          categoryId: categoryId,
        ),
      ),
    );
  }

  Future<void> getCategoriesApi() async {
    isLoading = true;
    notifyListeners();
    res = await Api.getCategories();
    isLoading = false;
    if (res.status == true) {
      debugPrint('data fetched>>');
    } else {}
    notifyListeners();
  }
}
