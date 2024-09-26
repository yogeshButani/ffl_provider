import 'package:fitforalegend_provider/const/app_appbar.dart';
import 'package:fitforalegend_provider/const/app_assets.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/const/app_grid_view.dart';
import 'package:fitforalegend_provider/const/app_network_image.dart';
import 'package:fitforalegend_provider/provider/sub_categories_provider.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<SubCategoriesProvider>(context, listen: false)
          .getSubCategoriesApi(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: const MyAppbar(
        title: 'Sub Categories',
      ),
      body: Consumer<SubCategoriesProvider>(builder: (context, provider, __) {
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
                var subCategory = provider.res.data?[index];
                return GestureDetector(
                  onTap: () => provider.onSubCategoryTap(
                    context: context,
                    categoryId: widget.categoryId,
                    subCategoryId: subCategory?.id ?? '',
                    subCategoryName: subCategory?.name ?? '',
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: AppNetworkImage(
                          image:
                              '${ApiServices.imageForCategories}${subCategory?.image}',
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
                          subCategory?.name ?? '',
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
