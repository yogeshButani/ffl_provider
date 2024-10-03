import 'package:fitforalegend_provider/const/app_appbar.dart';
import 'package:fitforalegend_provider/const/app_assets.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/const/app_grid_view.dart';
import 'package:fitforalegend_provider/const/app_network_image.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/provider/favorite_products_provider.dart';
import 'package:fitforalegend_provider/provider/products_by_categories_provider.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsByCategoriesScreen extends StatefulWidget {
  final String categoryId;
  final String subCategoryId;
  final String subCategoryName;

  const ProductsByCategoriesScreen({
    super.key,
    required this.categoryId,
    required this.subCategoryId,
    required this.subCategoryName,
  });

  @override
  State<ProductsByCategoriesScreen> createState() =>
      _ProductsByCategoriesScreenState();
}

class _ProductsByCategoriesScreenState
    extends State<ProductsByCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProductsByCategoriesProvider>(context, listen: false)
          .getChildCategoriesAndProductsApi(
        subCategoryId: widget.subCategoryId,
        categoryId: widget.categoryId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: MyAppbar(
        title: widget.subCategoryName,
      ),
      body: Consumer<ProductsByCategoriesProvider>(
          builder: (context, provider, __) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 35,
                child: Visibility(
                  visible: provider.childCategoryLoading == false,
                  replacement: const CircularProgressIndicator(),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: provider.childCategoryList.length,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var childCategory = provider.childCategoryList[index];
                      return GestureDetector(
                        onTap: () => provider.onChildCategoryTap(
                            index, widget.categoryId, widget.subCategoryId),
                        child: Container(
                          margin: const EdgeInsets.only(left: 7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: childCategory.selected == true
                                  ? AppColors.color17C6AA
                                  : AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: childCategory.selected == true
                                      ? Colors.transparent
                                      : AppColors.colorTextFieldBorder)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              childCategory.name ?? '',
                              style: TextStyle(
                                color: childCategory.selected == true
                                    ? AppColors.colorWhite
                                    : AppColors.colorBlack,
                                fontSize: 15,
                                fontFamily: AppFonts.poppinsRegular,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: GridView.builder(
                    itemCount: provider.productsList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            height: 280,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      var products = provider.productsList[index];
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: AppNetworkImage(
                                  image:
                                      '${ApiServices.imageForProducts}${products.images?[0].image ?? ''}',
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorWidget: Image.asset(
                                    AppAssets.errorImage,
                                    height: 160,
                                    width: 100,
                                  ),
                                ),
                              ),
                              Consumer<FavoriteProvider>(
                                  builder: (context, likeProvider, __) {
                                return GestureDetector(
                                  onTap: () {
                                    final favoriteProvider =
                                        Provider.of<FavoriteProvider>(context,
                                            listen: false);
                                    favoriteProvider.onLikeTap(
                                      products.id ?? '',
                                      products.isFavourite ?? '',
                                      provider.updateFavoriteStatus,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Visibility(
                                      visible: products.isFavourite == 'like',
                                      replacement: const Icon(
                                        Icons.favorite_border,
                                        size: 25,
                                        color: AppColors.color17C6AA,
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: AppColors.color17C6AA,
                                      ),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  products.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: AppFonts.poppinsRegular,
                                      color: Color(0xFF5E5E5E)),
                                )),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFFCAF23),
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      products.avgRating ?? '',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: AppFonts.poppinsRegular,
                                          color: Color(0xFF5E5E5E)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    Utility
                                        .calculatePriceDifferenceAndPercentage(
                                            double.parse(
                                                products.sellingPrice ?? ''),
                                            double.parse(
                                                products.costPrice ?? '')),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontFamily: AppFonts.poppinsSemiBold,
                                        color: Colors.pink),
                                  ),
                                ),
                                Text(
                                  '\$${products.costPrice ?? ''}',
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      fontFamily: AppFonts.poppinsLight,
                                      color: AppColors.colorBlack),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '\$${products.sellingPrice ?? ''}',
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: AppFonts.poppinsSemiBold,
                                    color: AppColors.colorBlack),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            )
          ],
        );
      }),
    );
  }
}
