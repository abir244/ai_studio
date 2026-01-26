import 'package:flutter/material.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../../core/theme/app_colors.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          height: 6,
          width: isActive ? 28 : 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryPurple : const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              side: const BorderSide(color: Color(0xFFF3F4F6), width: 1.5),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: _buildGradientButton()),
      ],
    );
  }

  Widget _buildGradientButton() {
    final bool isLastPage = vm.currentIndex == onboardingPages.length - 1;

    return Container(
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: AppColors.buttonGradient,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (!isLastPage) {
            setState(() => vm.next());
          } else {
            // Navigate to LoginPage when onboarding is done
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: Text(
          isLastPage
              ? 'Get Started'
              : onboardingPages[vm.currentIndex].buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
