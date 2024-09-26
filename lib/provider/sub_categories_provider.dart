import 'package:fitforalegend_provider/models/response_sub_categories.dart';
import 'package:fitforalegend_provider/screens/products_by_categories_screen.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';

class SubCategoriesProvider extends ChangeNotifier {
  SubCategoryResponse res = SubCategoryResponse();

  onSubCategoryTap({
    required BuildContext context,
    required String categoryId,
    required String subCategoryId,
    required String subCategoryName,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductsByCategoriesScreen(
          categoryId: categoryId,
          subCategoryId: subCategoryId,
          subCategoryName: subCategoryName,
        ),
      ),
    );
  }

  bool isLoading = false;

  Future<void> getSubCategoriesApi(String categoryId) async {
    isLoading = true;
    notifyListeners();
    Map<String, String> body = {
      'cat_id': categoryId,
    };
    res = await Api.getSubCategories(body: body);
    isLoading = false;
    if (res.status == true) {
      debugPrint('data fetched>>');
    } else {}
    notifyListeners();
  }
}
