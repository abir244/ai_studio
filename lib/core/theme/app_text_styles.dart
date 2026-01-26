import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24, // Refined lower font size
    fontWeight: FontWeight.w800,
    color: AppColors.textBlack,
    height: 1.2,
    letterSpacing: -0.6,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14, // Refined lower body size
    color: AppColors.textGrey,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle logoText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryPurple,
    letterSpacing: -0.5,
  );
}