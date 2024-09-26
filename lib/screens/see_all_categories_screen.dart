import 'package:fitforalegend_provider/const/app_appbar.dart';
import 'package:fitforalegend_provider/const/app_assets.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/const/app_grid_view.dart';
import 'package:fitforalegend_provider/const/app_network_image.dart';
import 'package:fitforalegend_provider/provider/categories_provider.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeAllCategoriesScreen extends StatefulWidget {
  const SeeAllCategoriesScreen({super.key});

  @override
  State<SeeAllCategoriesScreen> createState() => _SeeAllCategoriesScreenState();
}

class _SeeAllCategoriesScreenState extends State<SeeAllCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CategoriesProvider>(context, listen: false)
          .getCategoriesApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: const MyAppbar(
        title: 'All Categories',
      ),
      body: Consumer<CategoriesProvider>(builder: (context, provider, __) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.res.data?.isEmpty ?? true) {
          return const Center(
            child: Text('No Data Found'),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 15),
          child: GridView.builder(
              itemCount: provider.res.data?.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      height: 100,
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                var category = provider.res.data?[index];
                return GestureDetector(
                  onTap: () =>
                      provider.onCategoryTap(context, category?.id ?? ''),
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
                      ),
                    ],
                  ),
                );
              }),
        );
      }),
    );
  }
}
