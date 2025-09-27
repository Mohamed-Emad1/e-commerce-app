import 'package:flutter/material.dart';
import 'package:kshk/core/utils/assets.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/features/onboarding/presentation/view/widgets/dots.dart';
import 'package:kshk/generated/l10n.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
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
          SizedBox(height: 100),
          Image.asset(Assets.assetsImagesOnboardingSecond),
          Text(
            S.of(context).onboarding_second_subtitle,
            style: AppStyles.size30W700(context),
            textAlign: TextAlign.center,
          ),
          Text(
            S.of(context).onboarding_first_subtitle,
            style: AppStyles.size16W400(context),
            textAlign: TextAlign.center,
          ),

          Dots(currentIndex: index),
          // CustomButton(text: S.of(context).get_started),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(2);
                  },
                  child: Text(
                    S.of(context).skip,
                    style: AppStyles.size14W600(context),
                  ),
                ),
              ),
              Expanded(
                child: CustomButton(
                  text: S.of(context).next,
                  onPressed: () {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
