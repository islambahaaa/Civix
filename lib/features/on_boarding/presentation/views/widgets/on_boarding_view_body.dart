import 'package:civix_app/constants.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:civix_app/features/on_boarding/presentation/views/widgets/on_boarding_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(
      () {
        currentPage = pageController.page!.round();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: currentPage != 2,
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
          child: GestureDetector(
            onTap: () {
              Prefs.setBool(kIsOnBoardingSeen, true);
              Navigator.of(context).pushReplacementNamed(SigninView.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Skip',
                    style: TextStyles.regular17inter
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        Image.asset(
          Assets.imagesLogo,
          width: 200,
          height: 100,
          fit: BoxFit.contain,
        ),
        Expanded(
            child: OnBoardingPageView(
          pageController: pageController,
        )),
        SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: const ExpandingDotsEffect(
              activeDotColor: AppColors.primaryColor,
            )),
        const SizedBox(height: 29),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 116),
          child: currentPage == 2
              ? CustomButton(
                  text: 'Done',
                  onPressed: () {
                    Prefs.setBool(kIsOnBoardingSeen, true);
                    Navigator.of(context)
                        .pushReplacementNamed(SigninView.routeName);
                  },
                )
              : CustomButton(
                  text: 'Next',
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                ),
        ),
        const SizedBox(height: 43),
      ],
    );
  }
}
