import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          isVisible: true,
          image: Assets.animationsCaptureAnimation,
          subtitle: S.of(context).report_from_home,
          title: Text(
            S.of(context).comfort,
            style: TextStyles.bold28insturment
                .copyWith(color: AppColors.secondaryColor),
          ),
        ),
        PageViewItem(
          isVisible: true,
          image: Assets.animationsFixAnimation,
          subtitle: S.of(context).trusted_fix,
          title: Text(
            S.of(context).trust,
            style: TextStyles.bold28insturment
                .copyWith(color: AppColors.secondaryColor),
            textAlign: TextAlign.center,
          ),
        ),
        PageViewItem(
            isVisible: false,
            image: Assets.animationsOnBoarding33,
            subtitle: S.of(context).safe_neighborhood,
            title: Text(
              S.of(context).safety,
              style: TextStyles.bold28insturment
                  .copyWith(color: AppColors.secondaryColor),
            ))
      ],
    );
  }
}
