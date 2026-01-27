import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../../features/home/viewmodel/navigation_provider.dart';

class UniversalBottomNav extends ConsumerWidget {
  const UniversalBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(ref, 0, Icons.home_outlined, Icons.home_filled, "Home", currentIndex),
              _buildNavItem(ref, 1, Icons.explore_outlined, Icons.explore, "Discover", currentIndex),

              _buildCenterActionButton(ref), // Central Magic Button

              _buildNavItem(ref, 3, Icons.chat_bubble_outline, Icons.chat_bubble, "Chat", currentIndex),
              _buildNavItem(ref, 4, Icons.person_outline, Icons.person, "Profile", currentIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(WidgetRef ref, int index, IconData icon, IconData activeIcon, String label, int currentIndex) {
    bool isActive = currentIndex == index;
    Color color = isActive ? AppColors.primaryPurple : AppColors.textGrey;

    return GestureDetector(
      onTap: () => ref.read(navigationIndexProvider.notifier).state = index,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isActive ? activeIcon : icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterActionButton(WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(navigationIndexProvider.notifier).state = 2,
      child: Container(
        width: 70,
        height: 48,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
      ),
    );
  }
}