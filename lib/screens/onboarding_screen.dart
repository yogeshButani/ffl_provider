import 'package:fitforalegend_provider/const/app_colors.dart';
import 'package:fitforalegend_provider/provider/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../const/app_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).currentPage();
    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Consumer<OnBoardingProvider>(builder: (context, provider, __) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: provider.pageController,
                  itemCount: provider.list.length,
                  onPageChanged: (int page) => provider.onChangeIndex(page),
                  itemBuilder: (_, i) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            provider.list[i].image,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 1.4,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 51,
                          ),
                          Center(
                            child: Text(
                              provider.list[i].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textColor,
                                fontSize: 25,
                                fontFamily: AppFonts.poppinsBold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Text(
                            provider.list[i].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF90909F),
                              fontSize: 16,
                              fontFamily: AppFonts.poppinsRegular,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    provider.currentIndex != 0
                        ? GestureDetector(
                            onTap: () => provider.previousPage(context),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/ic_arrow_back.svg',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          )
                        : const SizedBox(height: 50, width: 50),
                    _buildDotsIndicator(
                        provider.list.length, provider.currentIndex),
                    GestureDetector(
                      onTap: () => provider.nextPage(context),
                      child: SvgPicture.asset('assets/images/ic_arrow_next.svg',
                          height: 50, width: 50),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        }));
  }

  Widget _buildDotsIndicator(int pageCount, int currentIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          double baseSize = 11.0;
          double increaseFactor = 3.5; // You can adjust this factor

          double dotSize =
              baseSize + (index == currentIndex ? increaseFactor : 0.0);

          return Container(
            width: dotSize,
            height: dotSize,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index
                  ? AppColors.dotsColor
                  : AppColors.dotColor, // Change active and inactive dot colors
            ),
          );
        }),
      ),
    );
  }
}
