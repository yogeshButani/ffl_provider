// import 'dart:developer';
//
// import 'package:fitforalegend/apiservices/common_wishlist_api_call.dart';
// import 'package:fitforalegend/screens/product_details_screen.dart';
// import 'package:fitforalegend/utils/my_app_assets.dart';
// import 'package:fitforalegend/utils/my_app_bar.dart';
// import 'package:fitforalegend/utils/my_inkwell.dart';
// import 'package:fitforalegend/utils/my_network_image.dart';
// import 'package:fitforalegend/utils/my_scaffold.dart';
// import 'package:fitforalegend/utils/my_utils.dart';
// import 'package:fitforalegend_provider/models/response_child_categories.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert' as convert;
// import '../apiservices/api_services.dart';
// import '../models/response_child_category.dart';
// import '../utils/my_colors.dart';
// import '../utils/my_fonts.dart';
// import '../utils/my_gridview.dart';
// import '../utils/my_navigations.dart';
// import '../utils/my_shimmer_effect.dart';
// import 'filter_screen.dart';
//
// // ignore: must_be_immutable
// class CategoryProductsScreen extends StatefulWidget {
//   String title;
//   String subCategoryId;
//   String categoryId;
//
//   CategoryProductsScreen(
//       {super.key,
//         required this.title,
//         required this.subCategoryId,
//         required this.categoryId});
//
//   @override
//   State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
// }
//
// class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
//   List<int> selectedItems = [];
//
//   ChildCategoryResponse res = ChildCategoryResponse();
//
//   List<ChildCategoryList> childCategoryList = [];
//
//   List<ChildProductsList> childProductsList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       allApis();
//     });
//   }
//
//   hitApi() {
//     childCategoryApi(
//       context: context,
//       childCategoryId: childCategoryId,
//       userId: userId,
//       brandIds: brandId,
//       colorIds: colorId,
//       sizeIds: sizeId,
//       startedPrice: startedPrice,
//       endedPrice: endPrice,
//       ratingFrom: startRating,
//       ratingTo: endRating,
//     );
//   }
//
//   String userId = '';
//
//   allApis() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userId = prefs.getString('user_id') ?? '';
//     checkUserLogin();
//     if (mounted) {
//       childCategoryApi(
//         context: context,
//         childCategoryId: '',
//         userId: userId,
//         brandIds: '',
//         colorIds: '',
//         sizeIds: '',
//         startedPrice: '',
//         endedPrice: '',
//         ratingFrom: '',
//         ratingTo: '',
//       );
//     }
//
//     // productsAccordingChildCategoryApi(
//     //   context: context,
//     //   childCategoryId: '',
//     //   endedPrice: '',
//     //   startedPrice: '',
//     // );
//     setState(() {});
//   }
//
//   String childCategoryId = '';
//   String startedPrice = '';
//   String endPrice = '';
//   String brandId = '';
//   String colorId = '';
//   String sizeId = '';
//
//   String startRating = '';
//   String endRating = '';
//
//   List<String> childCatIds = [];
//
//   getFilterValues(String start, String end, String brandIds, String colorIds,
//       String sizeIds, String ratingFrom, String ratingTo) {
//     debugPrint('brandId>> $brandIds');
//     debugPrint('colorId>> $colorIds');
//     debugPrint('sizeId>> $sizeIds');
//     setState(() {
//       startedPrice = start;
//       endPrice = end;
//       brandId = brandIds;
//       colorId = colorIds;
//       sizeId = sizeIds;
//       startRating = ratingFrom;
//       endRating = ratingTo;
//
//       if (mounted) {
//         childCategoryApi(
//           context: context,
//           childCategoryId: childCategoryId,
//           userId: userId,
//           brandIds: brandId,
//           colorIds: colorId,
//           sizeIds: sizeId,
//           startedPrice: startedPrice,
//           endedPrice: endPrice,
//           ratingFrom: startRating,
//           ratingTo: endRating,
//         );
//       }
//
//       // productsAccordingChildCategoryApi(
//       //   context: context,
//       //   childCategoryId: '',
//       //   startedPrice: startedPrice,
//       //   endedPrice: endPrice,
//       // );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MyScaffold(
//         appBar: MyAppbar(
//           title: widget.title,
//           action: GestureDetector(
//             onTap: () {
//               CustomNavigator.pushNavigate(
//                   context,
//                   FilterScreen(
//                     sendFilterValues: getFilterValues,
//                     startPrice: startedPrice,
//                     endPrice: endPrice,
//                     colorIds: colorId,
//                     brandIds: brandId,
//                     sizeIds: sizeId,
//                     ratingValue: '$startRating - $endRating',
//                   ));
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 15),
//               child: SvgPicture.asset(
//                 'assets/images/ic_circle_filter.svg',
//                 height: 40,
//                 width: 40,
//               ),
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 15),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: SizedBox(
//                   height: 35,
//                   child: enable
//                       ? shimmerEffectForSubCategory()
//                       : ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: childCategoryList.length,
//                       padding: EdgeInsets.zero,
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             if (true) {
//                               onCategoryTap(index);
//                               childCategoryApi(
//                                 context: context,
//                                 childCategoryId: childCategoryId,
//                                 userId: userId,
//                                 brandIds: brandId,
//                                 colorIds: colorId,
//                                 sizeIds: sizeId,
//                                 startedPrice: startedPrice,
//                                 endedPrice: endPrice,
//                                 ratingFrom: startRating,
//                                 ratingTo: endRating,
//                               );
//                             }
//                             enable = false;
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(left: 7),
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: childCategoryList[index].selected ==
//                                     true
//                                     ? MyColors.color17C6AA
//                                     : MyColors.colorWhite,
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                     color: childCategoryList[index]
//                                         .selected ==
//                                         true
//                                         ? Colors.transparent
//                                         : MyColors.colorTextFieldBorder)),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 10, right: 10),
//                               child: Text(
//                                 childCategoryList[index].name.toString(),
//                                 style: TextStyle(
//                                     color:
//                                     childCategoryList[index].selected ==
//                                         true
//                                         ? MyColors.colorWhite
//                                         : MyColors.colorBlack,
//                                     fontSize: 15,
//                                     fontFamily: MyFonts.poppinsRegular),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: enableProduct
//                     ? myShimmerEffect()
//                     : childProductsList.isEmpty
//                     ? Container(
//                     alignment: Alignment.center,
//                     child: const Text(
//                       'No Data',
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontFamily: MyFonts.poppinsRegular,
//                           color: MyColors.colorBlack),
//                     ))
//                     : GridView.builder(
//                     shrinkWrap: true,
//                     itemCount: childProductsList.length,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
//                         height: 280,
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 10,
//                         crossAxisSpacing: 15),
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       ProductDetailsScreen(
//                                         productId:
//                                         childProductsList[index]
//                                             .id
//                                             .toString(),
//                                         likeStatus:
//                                         childProductsList[index]
//                                             .isFavourite
//                                             .toString(),
//                                       ))).then((value) => {
//                             (value ?? false) ? hitApi() : null,
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Stack(
//                               alignment: Alignment.topRight,
//                               children: [
//                                 Container(
//                                     height: 160,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: const Color(0xFFC7F1EB),
//                                         borderRadius:
//                                         BorderRadius.circular(9)),
//                                     child: AppNetworkImage(
//                                       image: childProductsList[index]
//                                           .images!
//                                           .isNotEmpty
//                                           ? '${APIservices.imageForProducts}${childProductsList[index].images![0].image.toString()}'
//                                           : '',
//                                       height: 130,
//                                       width: 100,
//                                       errorWidget: Image.asset(
//                                         MyAssets.errorImage,
//                                         height: 130,
//                                         width: 100,
//                                       ),
//                                     )),
//                                 MyInkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       if (isLogin == true) {
//                                         if (childProductsList[index]
//                                             .isFavourite ==
//                                             'like') {
//                                           childProductsList[index]
//                                               .isFavourite = 'dislike';
//                                           WishlistApi().add(
//                                               context: context,
//                                               productId:
//                                               childProductsList[
//                                               index]
//                                                   .id
//                                                   .toString(),
//                                               removeItem: false,
//                                               status: 'dislike',
//                                               list: childProductsList);
//                                         } else {
//                                           childProductsList[index]
//                                               .isFavourite = 'like';
//                                           WishlistApi().add(
//                                               context: context,
//                                               productId:
//                                               childProductsList[
//                                               index]
//                                                   .id
//                                                   .toString(),
//                                               removeItem: false,
//                                               status: 'like',
//                                               list: childProductsList);
//                                         }
//                                       } else {
//                                         Utility().errorToast(
//                                             msg: 'Please login',
//                                             context: context);
//                                       }
//                                     });
//                                   },
//                                   child: Padding(
//                                       padding:
//                                       const EdgeInsets.all(7.0),
//                                       child: childProductsList[index]
//                                           .isFavourite ==
//                                           'like'
//                                           ? SvgPicture.asset(
//                                         'assets/images/ic_liked.svg',
//                                         height: 30,
//                                         width: 30,
//                                       )
//                                           : SvgPicture.asset(
//                                         'assets/images/ic_disliked.svg',
//                                         height: 30,
//                                         width: 30,
//                                       )),
//                                 )
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10),
//                               child: Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                       child: Text(
//                                         childProductsList[index]
//                                             .name
//                                             .toString(),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             fontSize: 15,
//                                             fontFamily:
//                                             MyFonts.poppinsRegular,
//                                             color: Color(0xFF5E5E5E)),
//                                       )),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.star_rounded,
//                                         color: Color(0xFFFCAF23),
//                                         size: 20,
//                                       ),
//                                       const SizedBox(
//                                         width: 4,
//                                       ),
//                                       Text(
//                                         childProductsList[index]
//                                             .avgRating
//                                             .toString(),
//                                         style: const TextStyle(
//                                             fontSize: 15,
//                                             fontFamily:
//                                             MyFonts.poppinsRegular,
//                                             color: Color(0xFF5E5E5E)),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       calculatePriceDifferenceAndPercentage(
//                                           double.parse(
//                                               childProductsList[index]
//                                                   .sellingPrice
//                                                   .toString()),
//                                           double.parse(
//                                               childProductsList[index]
//                                                   .costPrice
//                                                   .toString())),
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                           fontSize: 10,
//                                           fontFamily:
//                                           MyFonts.poppinsSemiBold,
//                                           color: Colors.pink),
//                                     ),
//                                   ),
//                                   Text(
//                                     '\$${childProductsList[index].costPrice.toString()}',
//                                     style: const TextStyle(
//                                         decoration:
//                                         TextDecoration.lineThrough,
//                                         fontSize: 12,
//                                         fontFamily:
//                                         MyFonts.poppinsLight,
//                                         color: MyColors.colorBlack),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10),
//                               child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   '\$${childProductsList[index].sellingPrice.toString()}',
//                                   style: const TextStyle(
//                                       fontSize: 13,
//                                       fontFamily:
//                                       MyFonts.poppinsSemiBold,
//                                       color: MyColors.colorBlack),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   bool enable = true;
//
//   bool enableProduct = true;
//
//   bool isLogin = false;
//
//   Future<void> checkUserLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? ifLogin = prefs.getBool('is_user_login');
//     if (ifLogin == true) {
//       isLogin = true;
//       setState(() {});
//     } else {
//       isLogin = false;
//     }
//   }
//
//   Widget shimmerEffectForSubCategory() {
//     return MyShimmerEffect(
//       child: SizedBox(
//         height: 150,
//         child: ListView.builder(
//           itemCount: 3,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return Card(
//               elevation: 1.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const SizedBox(
//                 width: 130,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   onCategoryTap(int index) {
//     if (index == 0) {
//       if (!(childCategoryList[index].selected ?? false)) {
//         for (var element in childCategoryList) {
//           if (element.name?.toLowerCase() == 'all') {
//             element.selected = true;
//           } else {
//             element.selected = false;
//           }
//           setState(() {});
//         }
//       }
//     } else {
//       childCategoryList.first.selected = false;
//
//       childCategoryList[index].selected =
//       !(childCategoryList[index].selected ?? false);
//
//       var count = childCategoryList.fold(0, (previousValue, element) {
//         if (element.selected ?? false) {
//           return previousValue + 1;
//         } else {
//           return previousValue;
//         }
//       });
//       if (count == 0) {
//         childCategoryList.first.selected = true;
//       }
//
//       setState(() {});
//     }
//   }
//
//   Future<void> childCategoryApi({
//     required BuildContext context,
//     required String childCategoryId,
//     required String userId,
//     required String startedPrice,
//     required String endedPrice,
//     required String brandIds,
//     required String colorIds,
//     required String sizeIds,
//     required String ratingFrom,
//     required String ratingTo,
//   }) async {
//     setState(() {});
//     enable = true;
//     enableProduct = true;
//     HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//
//     List<String> selectedCategoryId = [];
//     for (var element in childCategoryList) {
//       if ((element.selected ?? false) &&
//           !(element.name?.toLowerCase() == 'all')) {
//         selectedCategoryId.add(element.id ?? '');
//       }
//     }
//     var response = await http.get(
//         Uri.parse(
//             '${Uri.parse('${APIservices.childCategory}?subcat_id=${widget.subCategoryId}&cat_id=${widget.categoryId}&childcate_id=${selectedCategoryId.isEmpty ? '' : selectedCategoryId.join(',')}&user_id=$userId&brand_id=$brandIds&color_id=$colorIds&size_id=$sizeIds&price_from=$startedPrice&price_to=$endedPrice&rating_from=$ratingFrom&rating_to=$ratingTo')}'),
//         headers: {
//           "content-type": "application/json",
//           "accept": "application/json",
//           "api-access-token": APIservices.apiAccessToken,
//         });
//     enable = false;
//     enableProduct = false;
//     Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//     if (jsonResponse["status"] == true) {
//       childProductsList.clear();
//       res = ChildCategoryResponse.fromJson(jsonResponse);
//
//       /// Adding default value All in child category list with "" empty id
//       ///
//       if (childCategoryList.isEmpty) {
//         childCategoryList
//             .add(ChildCategoryList(id: '', name: "All", selected: true));
//         childCategoryList.addAll(res.data ?? []);
//       }
//       for (var childCategory in res.data ?? []) {
//         for (var product in childCategory.product ?? []) {
//           childProductsList.add(product);
//         }
//       }
//       // if ()
//       //   showSelectedItem(childCategoryId);
//
//       log('Success response>> $jsonResponse');
//       setState(() {});
//     } else {
//       log('failed response>> $jsonResponse');
//       if (mounted) {
//         Utility()
//             .errorToast(msg: jsonResponse["message"], context: this.context);
//       }
//       setState(() {});
//     }
//   }
//
//   Widget myShimmerEffect() {
//     return GridView.builder(
//         physics: const AlwaysScrollableScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: 4,
//         gridDelegate:
//         const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
//             height: 275,
//             crossAxisCount: 2,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 15),
//         itemBuilder: (BuildContext context, int index) {
//           return MyShimmerEffect(
//             child: Container(
//               height: 275,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(9),
//                 color: Colors.grey,
//               ),
//             ),
//           );
//         });
//   }
// }