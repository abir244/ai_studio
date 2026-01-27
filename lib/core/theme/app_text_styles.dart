import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // --- 1. HEADINGS ---

  // Used for "Welcome, Alex"
  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
    letterSpacing: -0.5,
  );

  // Used for "Discover", "Type your idea", "Aspect Ratio"
  static const TextStyle h2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
    letterSpacing: -0.4,
  );

  // Used for Category Card titles like "AI Art Generator"
  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  // --- 2. BODY & CAPTIONS ---

  // Standard body text
  static const TextStyle bodyMain = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
    height: 1.4,
  );

  // Smaller text for subtitles/captions (e.g., "Create stunning artwork...")
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  // Hint text for Input Fields
  static const TextStyle hintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // --- 3. COMPONENT SPECIFIC ---

  // "Generate Image" button text
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // Aspect Ratio text (1:1, 16:9)
  static const TextStyle chipText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // "See all" or "Register" links
  static const TextStyle linkText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPurple,
  );

  // --- 4. BRANDING ---
  static const TextStyle logoText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryPurple,
    letterSpacing: -1.0,
  );
}