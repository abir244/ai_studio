import 'package:flutter/material.dart';

enum OnboardingType {
  tiltedGrid,
  promptView,
  straightGrid,
  fannedStack, // The sigma page
}

class OnboardingContent {
  final String title;
  final String description;
  final List<String> images;
  final OnboardingType type;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.images,
    required this.type,
  });
}

// Define your 4 onboarding pages
final List<OnboardingContent> onboardingPages = [
  // Screen 1: Tilted Grid
  OnboardingContent(
    title: 'Unleash your creative power and ideas',
    description: 'Turn your ideas into stunning visuals with AI. Create and share your art effortlessly.',
    images: [
      'assets/images/onboarding/art1.png',
      // Add more images if needed
    ],
    type: OnboardingType.tiltedGrid,
  ),

  // Screen 2: Prompt View
  OnboardingContent(
    title: 'Explore Infinite creations by AI Artists',
    description: 'Discover stunning AI-generated art, get inspired, and explore creations from around the world.',
    images: [
      'assets/images/onboarding/portrait1.png',
    ],
    type: OnboardingType.promptView,
  ),

  // Screen 3: Straight Grid
  OnboardingContent(
    title: 'Unleash your creative power and ideas',
    description: 'Turn your ideas into stunning visuals with AI create and share your art effortlessly.',
    images: [
      'assets/images/onboarding/art2.png',
    ],
    type: OnboardingType.straightGrid,
  ),

  // Screen 4: Sigma Fanned Stack (Auth Page)
  OnboardingContent(
    title: '', // No title for sigma page
    description: '', // No description for sigma page
    images: [
      'assets/images/onboarding/main_girl.png', // Center main image
      'assets/images/onboarding/art1.png', // Top left
      'assets/images/onboarding/art2.png', // Top right
      'assets/images/onboarding/art3.png', // Bottom left
      'assets/images/onboarding/art4.png', // Bottom right
    ],
    type: OnboardingType.fannedStack,
  ),
];