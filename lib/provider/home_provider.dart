import 'package:fitforalegend_provider/const/app_storage.dart';
import 'package:fitforalegend_provider/const/app_storage_manager.dart';
import 'package:fitforalegend_provider/models/response_home.dart';
import 'package:fitforalegend_provider/services/apis.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool bannerLoading = false;

  HomeResponse res = HomeResponse();

  List<String> flashSale = [
    'All',
    'Newest',
    'Popular',
  ];

  int selectedSale = 0;

  String selectedSaleName = 'All';

  int get currentSale => selectedSale;

  onSaleTap(int index) {
    selectedSale = index;
    selectedSaleName = flashSale[index].toString();
    notifyListeners();
  }

  List<Mobilebanner> banners = [
    Mobilebanner(
        image:
            'https://t3.ftcdn.net/jpg/04/65/46/52/240_F_465465254_1pN9MGrA831idD6zIBL7q8rnZZpUCQTy.jpg'),
  ];

  HomeProvider() {
    homeApi();
  }
  Future<void> homeApi() async {
    bannerLoading = true;
    notifyListeners();

    String userId = await StorageManager.readData(AppStorage.userId) ?? '';
    debugPrint('userId>> $userId');
    Map<String, String> params = {
      'flash_sale_key': selectedSaleName,
      'user_id': userId,
    };

    res = await Api.home(body: params);
    bannerLoading = false;
    if (res.status == true) {
      /// For banners
      res.data?.mobilebanner?.removeAt(0);

      /// invalid image url at 0th index so removed it
      res.data?.mobilebanner?.addAll(banners);

      /// static images
      notifyListeners();
    } else {}
    notifyListeners();
  }



  void updateFavoriteStatus(String productId, String isFavorite) {
    res.data?.flashsale?.firstWhere((product) => product.id.toString() == productId.toString()).isFavourite = isFavorite;
    notifyListeners();
  }
}
