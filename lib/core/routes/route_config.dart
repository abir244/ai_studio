import 'package:flutter/material.dart';
// 1. Import the new MainScreen
import '../../features/home/presentation/pages/category_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/main_screen.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import 'route_name.dart';

class RouteConfig {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {

      case RouteName.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );

      case RouteName.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );

      case RouteName.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      case RouteName.registration:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );

      case RouteName.Category:
        return MaterialPageRoute(
          builder: (_) => const CategoryPage(),
        );

    // 2. Point homepage to MainScreen (The Shell with Bottom Nav)
      case RouteName.homepage:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
    }
  }
}