import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  Future<void> onLikeTap(
      String productId, String isFavorite, Function updateCallBack) async {
    if (isFavorite == 'like') {
      updateCallBack(productId, 'dislike');
      await favoriteApi(productId, 'dislike', updateCallBack);
    } else {
      updateCallBack(productId, 'like');
      await favoriteApi(productId, 'like', updateCallBack);
    }
    notifyListeners();
  }

  Future<void> favoriteApi(
      String productId, String status, Function updateCallBack) async {
    updateCallBack(productId, status);

    /// calling here to update the status on UI without taking loading
    Map<String, String> param = {
      'product_id': productId,
      'status': status,
    };
    var jsonResponse = await Api.favoriteProduct(body: param);
    if (jsonResponse['status'] == true) {
      Utility().getToast(jsonResponse['message']);
    } else {
      Utility().getToast(jsonResponse['message']);
    }
    notifyListeners();
  }
}

// class FavoriteProvider extends ChangeNotifier {
//   Future<void> onLikeTap(String productId, HomeProvider homeProvider) async {
//     final post = homeProvider.res.data?.flashsale
//         ?.firstWhere((product) => product.id == productId);
//     if (post != null) {
//       if (post.isFavourite == 'like') {
//         await favoriteApi(productId, 'dislike', homeProvider);
//       } else {
//         await favoriteApi(productId, 'like', homeProvider);
//       }
//     }
//     notifyListeners();
//   }
//
//   Future<void> favoriteApi(
//       String productId, String status, HomeProvider homeProvider) async {
//     homeProvider.updateFavoriteStatus(productId, status);
//
//     /// calling here to update the status on UI without taking loading
//     Map<String, String> param = {
//       'product_id': productId,
//       'status': status,
//     };
//     var jsonResponse = await Api.favoriteProduct(body: param);
//     if (jsonResponse['status'] == true) {
//       Utility().getToast(jsonResponse['message']);
//     } else {
//       Utility().getToast(jsonResponse['message']);
//     }
//     notifyListeners();
//   }
// }
