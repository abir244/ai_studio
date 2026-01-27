import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../model/onboarding_state.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingContent content;
  const OnboardingItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // 1. Background Visuals (The Grids/Images)
        Positioned(
          top: -20, left: -80, right: -80,
          child: SizedBox(
            height: screenHeight * 0.65,
            child: _buildExpansiveVisuals(context),
          ),
        ),

        // 2. Bottom Gradient Fade (Blends visuals into the text area)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.white.withOpacity(0.0),
                  AppColors.white.withOpacity(0.0),
                  AppColors.white.withOpacity(0.9),
                  AppColors.white,
                ],
                stops: const [0.0, 0.4, 0.7, 0.9],
              ),
            ),
          ),
        ),

        // 3. Content Text
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.22, // Adjusted for button space
              left: 32,
              right: 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1,
                ),
                const SizedBox(height: 16),
                Text(
                  content.description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMain,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpansiveVisuals(BuildContext context) {
    switch (content.type) {
      case OnboardingType.tiltedGrid:
        return Transform.rotate(
          angle: 0.15,
          child: Transform.scale(
            scale: 2.5,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: 12,
              itemBuilder: (context, i) => _ShowcaseCard(image: content.images[0]),
            ),
          ),
        );
      case OnboardingType.promptView:
        return Column(
          children: [
            const SizedBox(height: 100),
            const _PromptCard(),
            const Spacer(),
            _ShowcaseCard(
              image: content.images[0],
              width: 260,
              height: 340,
              borderRadius: 24,
            ),
            const Spacer(),
          ],
        );
      case OnboardingType.straightGrid:
        return Transform.scale(
          scale: 2.2,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemCount: 15,
            itemBuilder: (context, i) => _ShowcaseCard(image: content.images[0]),
          ),
        );
    }
  }
}

class _ShowcaseCard extends StatelessWidget {
  final String image;
  final double? width, height;
  final double borderRadius;

  const _ShowcaseCard({
    required this.image,
    this.width,
    this.height,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: AppColors.softShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          // Fallback if image asset is missing during dev
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.bgArtCard,
            child: const Icon(Icons.image, color: AppColors.primaryPurple),
          ),
        ),
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryPurple),
              const SizedBox(width: 8),
              Text("Prompt", style: AppTextStyles.cardTitle),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "A futuristic cyberpunk city with neon lights and flying cars at sunset...",
            style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}