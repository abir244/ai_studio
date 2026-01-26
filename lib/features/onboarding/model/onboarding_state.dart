enum OnboardingType { tiltedGrid, promptView, straightGrid }

class OnboardingContent {
  final String title;
  final String description;
  final OnboardingType type;
  final String buttonText;
  final List<String> images;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.type,
    required this.images,
    this.buttonText = "Next",
  });
}

final List<OnboardingContent> onboardingPages = [
  OnboardingContent(
    title: 'Unleash your creative\npower and ideas',
    description: 'Turn your ideas into stunning visuals with AI\ncreate and share your art effortlessly.',
    type: OnboardingType.tiltedGrid,
    images: List.generate(15, (index) => 'assets/images/image3.png'),
  ),
  OnboardingContent(
    title: 'Explore Infinite\ncreations by AI Artists',
    description: 'Discover stunning AI-generated art, get inspired,\nand explore creations from around the world.',
    type: OnboardingType.promptView,
    images: ['assets/images/image2.png'],
  ),
  OnboardingContent(
    title: 'Unleash your creative\npower and ideas',
    description: 'Turn your ideas into stunning visuals with AI\ncreate and share your art effortlessly.',
    type: OnboardingType.straightGrid,
    buttonText: "Get Start",
    images: List.generate(15, (index) => 'assets/images/image3.png'),
  ),
];