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

  // Helper to handle navigation to Login
  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Stack(
        children: [
          PageView.builder(
            controller: vm.pageController,
            itemCount: onboardingPages.length,
            onPageChanged: (index) => setState(() => vm.onPageChanged(index)),
            itemBuilder: (context, index) =>
                OnboardingItem(content: onboardingPages[index]),
          ),
          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: Column(
              children: [
                _buildDots(),
                const SizedBox(height: 40),
                _buildActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingPages.length, (index) {
        bool isActive = vm.currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 24 : 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryPurple : AppColors.borderLight,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons() {
    final bool isLastPage = vm.currentIndex == onboardingPages.length - 1;

    return Row(
      children: [
        // Skip Button - Only show if not on the last page
        if (!isLastPage)
          Expanded(
            child: TextButton(
              onPressed: _navigateToLogin,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Text(
                'Skip',
                style: AppTextStyles.bodyMain.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ),

        if (!isLastPage) const SizedBox(width: 16),

        // Next / Get Started Button
        Expanded(
          flex: isLastPage ? 2 : 1, // Make it full width on the last page
          child: _buildGradientButton(isLastPage),
        ),
      ],
    );
  }

  Widget _buildGradientButton(bool isLastPage) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (!isLastPage) {
            setState(() => vm.next());
          } else {
            _navigateToLogin();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Text(
          isLastPage ? 'Get Started' : 'Next',
          style: AppTextStyles.buttonLarge,
        ),
      ),
    );
  }
}