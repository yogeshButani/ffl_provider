import 'package:fitforalegend_provider/const/app_assets.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/const/app_grid_view.dart';
import 'package:fitforalegend_provider/const/app_network_image.dart';
import 'package:fitforalegend_provider/provider/favorite_products_provider.dart';
import 'package:fitforalegend_provider/provider/home_provider.dart';
import 'package:fitforalegend_provider/provider/user_profile_provider.dart';
import 'package:fitforalegend_provider/screens/see_all_categories_screen.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab1HomeScreen extends StatefulWidget {
  const Tab1HomeScreen({super.key});

  @override
  State<Tab1HomeScreen> createState() => _Tab1HomeScreenState();
}

class _Tab1HomeScreenState extends State<Tab1HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Consumer<HomeProvider>(builder: (context, provider, __) {
        if (provider.bannerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 50),
                child: Selector<UserProfileProvider, String>(
                  selector: (context, provider) =>
                      provider.res.data?.firstName ?? '',
                  builder: (context, firstName, __) {
                    return Text(
                      'Hii, $firstName',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: AppFonts.poppinsRegular,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AppNetworkImage(
                          image: '${provider.res.data?.mobilebanner?[0].image}',
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          errorWidget: Image.asset(AppAssets.errorImage),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          const Expanded(
                              child: Text(
                            'Categories',
                            style: TextStyle(
                                color: AppColors.color17C6AA,
                                fontFamily: AppFonts.poppinsSemiBold,
                                fontSize: 15),
                          )),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SeeAllCategoriesScreen()));
                            },
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                  color: AppColors.colorBlack,
                                  fontFamily: AppFonts.poppinsRegular,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: 80,
                      child: ListView.builder(
                          itemCount: provider.res.data!.category!.length >= 4
                              ? 4
                              : provider.res.data!.category!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var category = provider.res.data?.category?[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: AppNetworkImage(
                                      image:
                                          '${ApiServices.imageForCategories}${category?.image}',
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      errorWidget: Image.asset(
                                        AppAssets.errorImage,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      category?.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: AppColors.colorBlack,
                                          height: 0,
                                          fontFamily: AppFonts.poppinsRegular,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 15),
                      child: const Text(
                        'Flash Sale',
                        style: TextStyle(
                            color: AppColors.color17C6AA,
                            fontFamily: AppFonts.poppinsSemiBold,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: 38,
                      alignment: Alignment.topLeft,
                      child: ListView.builder(
                          itemCount: provider.flashSale.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var sale = provider.flashSale[index];
                            return GestureDetector(
                              onTap: () => provider.onSaleTap(index),
                              child: Container(
                                height: 38,
                                width: 80,
                                margin: const EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: provider.currentSale == index
                                      ? AppColors.color17C6AA
                                      : AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: provider.currentSale == index
                                        ? AppColors.color17C6AA
                                        : AppColors.colorBlack,
                                  ),
                                ),
                                child: Text(
                                  sale.toString(),
                                  style: TextStyle(
                                    color: provider.currentSale == index
                                        ? AppColors.colorWhite
                                        : AppColors.colorBlack,
                                    fontSize: 13,
                                    fontFamily: AppFonts.poppinsRegular,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GridView.builder(
                          itemCount: provider.res.data?.flashsale?.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                  height: 280,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (BuildContext context, int index) {
                            var products = provider.res.data?.flashsale?[index];
                            return Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: AppNetworkImage(
                                        image:
                                            '${ApiServices.imageForProducts}${products?.images?[0].image ?? ''}',
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
                                              Provider.of<FavoriteProvider>(
                                                  context,
                                                  listen: false);
                                          favoriteProvider.onLikeTap(
                                            products?.id ?? '',
                                            products?.isFavourite ?? '',
                                            provider.updateFavoriteStatus,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Visibility(
                                            visible:
                                                products?.isFavourite == 'like',
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
                                        products?.name ?? '',
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
                                            products?.avgRating ?? '',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily:
                                                    AppFonts.poppinsRegular,
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
                                          provider
                                              .calculatePriceDifferenceAndPercentage(
                                                  double.parse(
                                                      products?.sellingPrice ??
                                                          ''),
                                                  double.parse(
                                                      products?.costPrice ??
                                                          '')),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily:
                                                  AppFonts.poppinsSemiBold,
                                              color: Colors.pink),
                                        ),
                                      ),
                                      Text(
                                        '\$${products?.costPrice ?? ''}',
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
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
                                      '\$${products?.sellingPrice ?? ''}',
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
                  ],
                ),
              )),
            ],
          ),
        );
      }),
    );
  }
}
