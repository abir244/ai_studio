import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import 'route_name.dart';

class RouteConfig {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {

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
          builder: (_) => RegisterPage(),
        );


      case RouteName.splash:
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
    }
  }
}
