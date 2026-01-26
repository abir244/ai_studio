import 'package:flutter/material.dart';

class OnboardingViewModel {
  final PageController pageController = PageController();
  int currentIndex = 0;

  void onPageChanged(int index) => currentIndex = index;

  void next() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }
}