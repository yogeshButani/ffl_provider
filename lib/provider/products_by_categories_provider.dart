import 'package:fitforalegend_provider/const/app_storage.dart';
import 'package:fitforalegend_provider/const/app_storage_manager.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/models/response_child_categories.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';

class ProductsByCategoriesProvider extends ChangeNotifier {
  ChildCategoryResponse res = ChildCategoryResponse();

  bool childCategoryLoading = false;
  bool productsLoading = false;

  onChildCategoryTap(int index) {
    var childCategoryList = res.data ?? [];

    if (index == 0) {
      debugPrint('!!!!!>');
      if (!(childCategoryList[index].selected ?? false)) {
        debugPrint('xxx>> ${!(childCategoryList[index].selected ?? false)}');
        for (var element in childCategoryList) {
          if (element.name?.toLowerCase() == 'all') {
            element.selected = true;
            debugPrint('All is tapped >>');
          } else {
            debugPrint('Other item is tapped ${element.name} >>');
            element.selected = false;
          }
        }
      } else {
        debugPrint('@@@@>');
      }
    } else {
      childCategoryList.first.selected = false;
      childCategoryList[index].selected =
          !(childCategoryList[index].selected ?? false);
      var count = childCategoryList.fold(0, (previousValue, element) {
        if (element.selected ?? false) {
          return previousValue + 1;
        } else {
          return previousValue;
        }
      });

      if (count == 0) {
        childCategoryList.first.selected = true;
      }
    }
    notifyListeners();
  }

  Future<void> getChildCategoriesAndProductsApi({
    required String subCategoryId,
    required String categoryId,
    required String childCategoryId,
  }) async {
    String userId = await StorageManager.readData(AppStorage.userId) ?? '';
    childCategoryLoading = true;
    productsLoading = true;
    notifyListeners();
    Map<String, String> body = {
      'subcat_id': subCategoryId,
      'cat_id': categoryId,
      'childcate_id': childCategoryId,
      'user_id': userId,
      'brand_id': '',
      'color_id': '',
      'size_id': '',
      'price_from': '',
      'price_to': '',
      'rating_from': '',
      'rating_to': '',
    };
    res = await Api.getChildCategoriesAndProducts(body: body);
    childCategoryLoading = false;
    productsLoading = false;
    if (res.status == true) {
      res.data?.insert(
        0,
        ChildCategoryList(
          id: '',
          name: "All",
          selected: true,
        ),
      );
    } else {
      Utility().getToast(res.message);
    }
    notifyListeners();
  }
}
