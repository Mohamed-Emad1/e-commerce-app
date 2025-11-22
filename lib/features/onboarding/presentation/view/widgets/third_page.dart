import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/utils/assets.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/features/onboarding/presentation/view/widgets/dots.dart';
import 'package:kshk/generated/l10n.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({
    super.key,
    required this.index,
    required this.pageController,
  });

  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        spacing: 30,

        children: [
          const SizedBox(height: 100),
          Image.asset(Assets.assetsImagesOnboardingThird),
          Text(
            S.of(context).onboarding_first_title,
            style: AppStyles.size30W700(context),
            textAlign: TextAlign.center,
          ),
          Text(
            S.of(context).onboarding_first_subtitle,
            style: AppStyles.size16W400(context),
            textAlign: TextAlign.center,
          ),

          Dots(currentIndex: index),
          CustomButton(
            text: S.of(context).get_started,
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.kSignin);
            },
          ),
        ],
      ),
    );
  }
}
