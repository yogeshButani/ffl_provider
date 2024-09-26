import 'package:fitforalegend_provider/const/app_appbar.dart';
import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/const/app_fonts.dart';
import 'package:fitforalegend_provider/provider/products_by_categories_provider.dart';
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
        childCategoryId: '',
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
        if (provider.childCategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: provider.res.data?.length,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var childCategory = provider.res.data?[index];
                      return GestureDetector(
                        onTap: () => provider.onChildCategoryTap(index),
                        child: Container(
                          margin: const EdgeInsets.only(left: 7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: childCategory?.selected == true
                                  ? AppColors.color17C6AA
                                  : AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: childCategory?.selected == true
                                      ? Colors.transparent
                                      : AppColors.colorTextFieldBorder)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              childCategory?.name ?? '',
                              style: TextStyle(
                                color: childCategory?.selected == true
                                    ? AppColors.colorWhite
                                    : AppColors.colorBlack,
                                fontSize: 15,
                                fontFamily: AppFonts.poppinsRegular,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      }),
    );
  }
}
