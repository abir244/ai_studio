import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_name.dart';
import '../../model/onboarding_state.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingContent content;
  const OnboardingItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isFanned = content.type == OnboardingType.fannedStack;

    return Stack(
      children: [
        // 1. Background visuals
        Positioned(
          top: isFanned ? screenHeight * 0.05 : -screenHeight * 0.05,
          left: isFanned ? 0 : -screenWidth * 0.1,
          right: isFanned ? 0 : -screenWidth * 0.1,
          bottom: isFanned ? screenHeight * 0.32 : screenHeight * 0.28,
          child: ClipRect(
            child: _buildExpansiveVisuals(context),
          ),
        ),

        // 2. Bottom Gradient Fade
        if (!isFanned)
          Positioned(
            top: screenHeight * 0.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withOpacity(0.0),
                    AppColors.white.withOpacity(0.5),
                    AppColors.white.withOpacity(0.9),
                    AppColors.white,
                  ],
                  stops: const [0.0, 0.25, 0.6, 0.85],
                ),
              ),
            ),
          ),

        // 3. Bottom gradient for fanned stack
        if (isFanned)
          Positioned(
            top: screenHeight * 0.55,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withOpacity(0.0),
                    AppColors.white.withOpacity(0.7),
                    AppColors.white,
                  ],
                  stops: const [0.0, 0.4, 0.8],
                ),
              ),
            ),
          ),

        // 4. Content - Auth buttons for fanned, text for others
        if (isFanned)
          Positioned(
            bottom: screenHeight * 0.04,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: _buildAuthButtons(context),
          )
        else
          Positioned(
            bottom: screenHeight * 0.18,
            left: 0,
            right: 0,
            child: _buildTextContent(screenHeight, screenWidth),
          ),
      ],
    );
  }

  // --- THE FANNED "SIGMA" STACK ---
  Widget _buildFannedStack(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardW = screenWidth * 0.42;

    return Center(
      child: SizedBox(
        width: screenWidth,
        height: screenHeight * 0.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Top Left Card
            _PositionedFannedCard(
              image: content.images.length > 1 ? content.images[1] : content.images[0],
              angle: -0.22,
              offset: Offset(-screenWidth * 0.22, -screenHeight * 0.14),
              width: cardW,
              height: screenHeight * 0.35,
            ),
            // Top Right Card
            _PositionedFannedCard(
              image: content.images.length > 2 ? content.images[2] : content.images[0],
              angle: 0.18,
              offset: Offset(screenWidth * 0.25, -screenHeight * 0.1),
              width: cardW,
              height: screenHeight * 0.35,
            ),
            // Bottom Left Card
            _PositionedFannedCard(
              image: content.images.length > 3 ? content.images[3] : content.images[0],
              angle: -0.12,
              offset: Offset(-screenWidth * 0.18, screenHeight * 0.15),
              width: cardW * 0.85,
              height: screenHeight * 0.28,
            ),
            // Bottom Right Card
            _PositionedFannedCard(
              image: content.images.length > 4 ? content.images[4] : content.images[0],
              angle: 0.10,
              offset: Offset(screenWidth * 0.21, screenHeight * 0.16),
              width: cardW * 0.85,
              height: screenHeight * 0.28,
            ),
            // CENTER MAIN CARD
            _PositionedFannedCard(
              image: content.images[0],
              angle: 0,
              offset: const Offset(0, 0),
              width: screenWidth * 0.55,
              height: screenHeight * 0.42,
              isMain: true,
            ),
          ],
        ),
      ),
    );
  }

  // --- AUTH BUTTONS (Login, Sign Up, Guest) ---
  Widget _buildAuthButtons(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // SIGN UP BUTTON
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, RouteName.registration),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                  side: BorderSide(color: AppColors.borderLight, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.075),
                  ),
                  backgroundColor: AppColors.white,
                ),
                child: Text(
                  "Sign Up",
                  style: AppTextStyles.buttonLarge.copyWith(
                    fontSize: screenHeight * 0.019,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            // LOGIN BUTTON
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(screenWidth * 0.075),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, RouteName.login),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.075),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: AppTextStyles.buttonLarge.copyWith(
                      fontSize: screenHeight * 0.019,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.035),
        // GUEST BUTTON
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, RouteName.homepage),
          child: Text(
            "Continue as Guest",
            style: AppTextStyles.bodyMain.copyWith(
              fontSize: screenHeight * 0.018,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Standard Title/Description content
  Widget _buildTextContent(double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h1.copyWith(
              fontSize: screenHeight * 0.026,
              height: 1.3,
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMain.copyWith(
              fontSize: screenHeight * 0.017,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- VISUAL SWITCHER ---
  Widget _buildExpansiveVisuals(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    switch (content.type) {
      case OnboardingType.fannedStack:
        return _buildFannedStack(context);

      case OnboardingType.tiltedGrid:
        return LayoutBuilder(
          builder: (context, constraints) {
            return Transform.rotate(
              angle: -0.15,
              child: Center(
                child: SizedBox(
                  width: screenWidth * 1.5,
                  height: screenHeight * 0.85,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: screenWidth * 0.025,
                      mainAxisSpacing: screenWidth * 0.025,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: 15,
                    itemBuilder: (context, i) => _ShowcaseCard(
                      image: content.images[0],
                      borderRadius: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
            );
          },
        );

      case OnboardingType.promptView:
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              color: AppColors.white,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const _PromptCard(),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      _ShowcaseCard(
                        image: content.images[0],
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.42,
                        borderRadius: screenWidth * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );

      case OnboardingType.straightGrid:
        return LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: SizedBox(
                  width: screenWidth * 1.1,
                  height: screenHeight * 0.8,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: screenWidth * 0.015,
                      mainAxisSpacing: screenWidth * 0.015,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: 18,
                    itemBuilder: (context, i) => _ShowcaseCard(
                      image: content.images[0],
                      borderRadius: screenWidth * 0.03,
                    ),
                  ),
                ),
              ),
            );
          },
        );
    }
  }
}

// --- FANNED CARD COMPONENT ---
class _PositionedFannedCard extends StatelessWidget {
  final String image;
  final double angle;
  final Offset offset;
  final double width;
  final double height;
  final bool isMain;

  const _PositionedFannedCard({
    required this.image,
    required this.angle,
    required this.offset,
    required this.width,
    required this.height,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isMain ? Border.all(color: AppColors.white, width: 3) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.surfaceGrey,
                child: Icon(
                  Icons.image_outlined,
                  color: AppColors.textHint,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- SHOWCASE CARD ---
class _ShowcaseCard extends StatelessWidget {
  final String image;
  final double? width, height;
  final double borderRadius;

  const _ShowcaseCard({
    required this.image,
    this.width,
    this.height,
    this.borderRadius = 16,
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
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.surfaceGrey,
            child: Icon(
              Icons.image_outlined,
              color: AppColors.textHint,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

// --- PROMPT CARD ---
class _PromptCard extends StatelessWidget {
  const _PromptCard();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: screenWidth * 0.04,
                color: AppColors.primaryPurple,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                "Prompt",
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: screenHeight * 0.017,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.012),
          Text(
            "On the moon's rugged surface, a man race on a low-gravity cycle towards a mysterious structure. Earth looms in the sky; his face reflects determination and curiosity",
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: screenHeight * 0.016,
              height: 1.5,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenHeight * 0.015),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.008,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceGrey,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Icon(
                  Icons.add,
                  size: screenWidth * 0.035,
                  color: AppColors.textGrey,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.008,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceGrey,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: screenWidth * 0.035,
                      color: AppColors.textGrey,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      "0",
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: screenHeight * 0.015,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}