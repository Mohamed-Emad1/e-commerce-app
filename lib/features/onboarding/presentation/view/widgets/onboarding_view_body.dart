import 'package:flutter/material.dart';
import 'package:kshk/features/onboarding/presentation/view/widgets/first_page.dart';
import 'package:kshk/features/onboarding/presentation/view/widgets/second_page.dart';
import 'package:kshk/features/onboarding/presentation/view/widgets/third_page.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      children: [
        FirstPage(index: currentIndex, pageController: _pageController),
        SecondPage(index: currentIndex, pageController: _pageController),
        ThirdPage(index: currentIndex, pageController: _pageController),
      ],
    );
  }
}
