import 'package:flutter/material.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../model/onboarding_state.dart';
import '../../viewmodel/onboarding_viewmodel.dart';
import '../widgets/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late OnboardingViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = OnboardingViewModel();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Check if current page is the sigma fanned stack (last page)
    final bool isSigmaPage = vm.currentIndex == onboardingPages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: vm.pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (index) => setState(() => vm.onPageChanged(index)),
              itemBuilder: (context, index) =>
                  OnboardingItem(content: onboardingPages[index]),
            ),

            // Bottom section with dots and buttons - HIDDEN on sigma page
            if (!isSigmaPage)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.025,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDots(),
                      SizedBox(height: screenHeight * 0.025),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingPages.length - 1, (index) { // -1 to exclude sigma page
        bool isActive = vm.currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 20 : 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryPurple : AppColors.borderLight,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLastRegularPage = vm.currentIndex == onboardingPages.length - 2; // Second to last

    return Row(
      children: [
        // Skip button
        Expanded(
          child: OutlinedButton(
            onPressed: _navigateToLogin,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              side: BorderSide(color: AppColors.borderLight, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.07),
              ),
              backgroundColor: AppColors.white,
            ),
            child: Text(
              'Skip',
              style: AppTextStyles.buttonLarge.copyWith(
                fontSize: screenHeight * 0.018,
                color: AppColors.textBlack,
              ),
            ),
          ),
        ),

        SizedBox(width: screenWidth * 0.03),

        // Next/Get Started button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (!isLastRegularPage) {
                setState(() => vm.next());
              } else {
                // Navigate to sigma page
                setState(() => vm.next());
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.07),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              isLastRegularPage ? 'Get Start' : 'Next',
              style: AppTextStyles.buttonLarge.copyWith(
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        ),
      ],
    );
  }
}