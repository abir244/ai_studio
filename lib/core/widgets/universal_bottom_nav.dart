import 'package:ai_studio/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../../features/home/viewmodel/navigation_provider.dart';
// Assuming RouteName is defined in your constants/routes file
// import '../../core/routes/route_names.dart';

class UniversalBottomNav extends ConsumerWidget {
  const UniversalBottomNav({super.key});

  final String imagePath = 'assets/images';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(45),
            border: Border.all(color: Colors.grey.withOpacity(0.12)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, ref, 0, '$imagePath/home.png', currentIndex),
              _buildNavItem(context, ref, 1, '$imagePath/discover.png', currentIndex),

              _buildMagicButton(ref),

              _buildNavItem(context, ref, 3, '$imagePath/chat.png', currentIndex),
              _buildNavItem(context, ref, 4, '$imagePath/profile.png', currentIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, WidgetRef ref, int index, String assetPath, int currentIndex) {
    bool isActive = currentIndex == index;

    return GestureDetector(
      // Inside your _buildNavItem function, update the onTap:
      onTap: () {
        HapticFeedback.lightImpact();

        if (index == 3) {
          // FIX: Pass the Map arguments that RouteConfig is looking for
          Navigator.pushNamed(
            context,
            RouteName.ListPage,
            arguments: {
              'conversationId': 'main_room_001',
              'conversationName': 'AI Studio Chat',
            },
          );
        } else {
          ref.read(navigationIndexProvider.notifier).state = index;
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: isActive ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Image.asset(
          assetPath,
          width: 40,
          height: 40,
          color: isActive ? AppColors.primaryPurple : AppColors.textGrey.withOpacity(0.5),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildMagicButton(WidgetRef ref) {
    final bool isSelected = ref.watch(navigationIndexProvider) == 2;

    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        ref.read(navigationIndexProvider.notifier).state = 2;
      },
      child: AnimatedScale(
        scale: isSelected ? 1.12 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: Container(
          width: 82,
          height: 58,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.4),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}

// Ensure RouteName is defined elsewhere or add it here for testing:
// class RouteName {
//   static const String ChatRoom = '/chat-room';
// }