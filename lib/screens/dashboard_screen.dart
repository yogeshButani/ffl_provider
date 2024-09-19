import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/provider/dasboard_bottombar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedIndex;

  const DashboardScreen({super.key, required this.selectedIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Provider.of<DashboardBottomBarProvider>(context, listen: false)
        .selectedTab = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 85,
        padding: const EdgeInsets.symmetric(vertical: 10.5, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.color17C6AA.withOpacity(0.5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: tabButton(
                  activeIcon: 'assets/images/ic_bnb_selected_home.svg',
                  inActiveIcon: 'assets/images/ic_bnb_home.svg',
                  context: context,
                  index: 0),
            ),
            Expanded(
              flex: 1,
              child: tabButton(
                  activeIcon: 'assets/images/ic_bnb_selected_cart.svg',
                  inActiveIcon: 'assets/images/ic_bnb_cart.svg',
                  context: context,
                  index: 1),
            ),
            Expanded(
              flex: 1,
              child: tabButton(
                  activeIcon: 'assets/images/ic_bnb_selected_whishlist.svg',
                  inActiveIcon: 'assets/images/ic_bnb_whishlist.svg',
                  context: context,
                  index: 2),
            ),
            Expanded(
              flex: 1,
              child: tabButton(
                  activeIcon: 'assets/images/ic_bnb_selected_tab_3.svg',
                  inActiveIcon: 'assets/images/ic_bnb_tab_3.svg',
                  context: context,
                  index: 3),
            ),
            Expanded(
              flex: 1,
              child: tabButton(
                  activeIcon: 'assets/images/ic_bnb_selected_profile.svg',
                  inActiveIcon: 'assets/images/ic_bnb_profile.svg',
                  context: context,
                  index: 4),
            ),
          ],
        ),
      ),
      body: getPage(
          Provider.of<DashboardBottomBarProvider>(context, listen: false)
              .currentTab),
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return Container();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return Container();
      default:
        return Container();
    }
  }

  Widget tabButton(
      {required String activeIcon,
      required String inActiveIcon,
      required BuildContext context,
      required int index}) {
    return Consumer<DashboardBottomBarProvider>(
        builder: (context, provider, __) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => provider.onTap(index),
        child: SvgPicture.asset(
          provider.currentTab == index ? activeIcon : inActiveIcon,
          width: provider.currentTab == index ? 45 : 24,
          height: provider.currentTab == index ? 45 : 24,
        ),
      );
    });
  }
}
