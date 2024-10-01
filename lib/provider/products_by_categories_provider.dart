import 'package:fitforalegend_provider/const/app_storage.dart';
import 'package:fitforalegend_provider/const/app_storage_manager.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/models/response_child_categories.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';

class ProductsByCategoriesProvider extends ChangeNotifier {
  ChildCategoryResponse res = ChildCategoryResponse();
  List<ChildProductsList> productsList = [];

  bool childCategoryLoading = false;
  bool productsLoading = false;

  onChildCategoryTap(int index, String categoryId, String subCategoryId) {
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
      debugPrint('count>>>$count');
      if (count == 0) {
        childCategoryList.first.selected = true;
        debugPrint('All selected after de-select other items');
      }
    }
    getChildCategoriesAndProductsApi(subCategoryId: subCategoryId, categoryId: categoryId);
    childCategoryLoading = false;
    notifyListeners();
  }


  Future<void> getChildCategoriesAndProductsApi({
    required String subCategoryId,
    required String categoryId,
  }) async {
    String userId = await StorageManager.readData(AppStorage.userId) ?? '';
    childCategoryLoading = true;
    productsLoading = true;
    List<String> selectedCategoryId = [];
    for (var element in res.data ?? []) {
      if ((element.selected ?? false) &&
          !(element.name?.toLowerCase() == 'all')) {
        selectedCategoryId.add(element.id ?? '');
      }
    }
    debugPrint('selectedCategoryId>>${selectedCategoryId.length}');
    notifyListeners();
    Map<String, String> body = {
      'subcat_id': subCategoryId,
      'cat_id': categoryId,
      'childcate_id': selectedCategoryId.join(','),
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
      productsList.clear();
      res.data?.insert(
        0,
        ChildCategoryList(
          id: '',
          name: "All",
          selected: true,
        ),
      );

      for (var childCategory in res.data ?? []) {
        for (var product in childCategory.product ?? []) {
          productsList.add(product);
        }
      }
    } else {
      Utility().getToast(res.message);
    }
    notifyListeners();
  }
  void updateFavoriteStatus(String productId, String isFavorite) {
    productsList.firstWhere((product) => product.id.toString() == productId.toString()).isFavourite = isFavorite;
    notifyListeners();
  }
}
