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
        Positioned(
          top: -20, left: -80, right: -80,
          child: SizedBox(
            height: screenHeight * 0.65,
            child: _buildExpansiveVisuals(context),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.95),
                  Colors.white,
                ],
                stops: const [0.0, 0.4, 0.6, 0.75],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.18, left: 40, right: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content.title, textAlign: TextAlign.center, style: AppTextStyles.heading),
                const SizedBox(height: 12),
                Text(content.description, textAlign: TextAlign.center, style: AppTextStyles.body),
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
          angle: 0.20,
          child: Transform.translate(
            offset: const Offset(40, 0),
            child: Transform.scale(
              scale: 3.0,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.85),
                itemCount: 15,
                itemBuilder: (context, i) => _ShowcaseCard(image: content.images[0]),
              ),
            ),
          ),
        );
      case OnboardingType.promptView:
        return Column(
          children: [
            const SizedBox(height: 80),
            _PromptCard(),
            const Spacer(),
            _ShowcaseCard(image: content.images[0], width: 280, height: 360, borderRadius: 24),
            const Spacer(),
          ],
        );
      case OnboardingType.straightGrid:
        return Transform.scale(
          scale: 2.60,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.9),
            itemCount: 18,
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
  const _ShowcaseCard({required this.image, this.width, this.height, this.borderRadius = 18});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.15)),
        boxShadow: [BoxShadow(color: AppColors.primaryPurple.withOpacity(0.05), blurRadius: 20)],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Prompt", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
          SizedBox(height: 6),
          Text("On the moon's rugged surface...\n ", style: TextStyle(color: Colors.grey, fontSize: 11, height: 1.4)),
        ],
      ),
    );
  }
}