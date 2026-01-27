import 'package:flutter/material.dart';

class AppColors {
  // --- Brand Colors ---
  static const Color primaryPurple = Color(0xFF6C63FF);
  static const Color primaryDeep = Color(0xFF4B45AD);
  static const Color primaryLight = Color(0xFF8E86FF);

  // --- Text Colors ---
  static const Color textBlack = Color(0xFF111827);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // --- Surface Colors ---
  static const Color white = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFFFFFFF);
  static const Color surfaceGrey = Color(0xFFF9FAFB);
  static const Color chipInactive = Color(0xFFF3F4F6);
  static const Color borderLight = Color(0xFFE5E7EB);

  // --- Category Card Backgrounds (Pastels from Figma) ---
  static const Color bgArtCard = Color(0xFFE8E8FF);    // AI Art Generator
  static const Color bgSketchCard = Color(0xFFF5F0FF); // AI Sketch
  static const Color bgFriendCard = Color(0xFFF0F5FF); // AI Friend
  static const Color premiumDark = Color(0xFF3F3D56);  // Dark side of Premium card

  // --- Functional Accents ---
  static const Color starAmber = Color(0xFFFBBF24);    // Pro/Star icons
  static const Color successGreen = Color(0xFF10B981);
  static const Color errorRed = Color(0xFFEF4444);

  // --- GRADIENTS ---

  // Main Action (Generate Button)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Selected Aspect Ratio Gradient
  static const LinearGradient selectedRatioGradient = LinearGradient(
    colors: [primaryPurple, primaryDeep],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Premium Features Card Gradient
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [primaryPurple, premiumDark],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // --- SHADOWS ---
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 15,
      offset: const Offset(0, 8),
    ),
  ];
}