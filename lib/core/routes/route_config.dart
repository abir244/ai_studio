import 'package:ai_studio/features/chat/presentation/pages/chat_room_page.dart';
import 'package:ai_studio/features/chat/presentation/pages/join_room_page.dart';
import 'package:flutter/material.dart';
import '../../features/chat/presentation/pages/chat_list_page.dart';
import '../../features/chat/presentation/pages/create_room_page.dart';
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
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case RouteName.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case RouteName.ChatRoom:
      // FIX: Extracting arguments safely to prevent Null subtype error
        final args = settings.arguments as Map<String, dynamic>? ?? {
          'conversationId': 'default_id',
          'conversationName': 'New Chat',
        };
        return MaterialPageRoute(
          builder: (_) => ChatRoomPage(
            conversationId: args['conversationId'],
            conversationName: args['conversationName'],
          ),
        );

      case RouteName.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      // case RouteName.ListPage:
      //   return MaterialPageRoute(builder:(_) => const UserListPage());

      case RouteName.registration:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case RouteName.Category:
        return MaterialPageRoute(builder: (_) => const CategoryPage());

      case RouteName.homepage:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case RouteName.CreateRoomPage:
        return MaterialPageRoute(builder: (_) => const CreateRoomPage());

      case RouteName.JoinRoomPage:
        return MaterialPageRoute(builder: (_) => const JoinRoomPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}