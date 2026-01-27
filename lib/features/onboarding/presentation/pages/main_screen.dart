import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/universal_bottom_nav.dart';
import '../../../home/presentation/pages/category_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../home/viewmodel/navigation_provider.dart';


class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    // Swap screens based on tab index
    final List<Widget> pages = [
      const HomePage(),      // Index 0
      const CategoryPage(),  // Index 1
      const HomePage(),      // Index 2 (Center Action)
      const Center(child: Text("Chat")),    // Index 3
      const Center(child: Text("Profile")), // Index 4
    ];

    return Scaffold(
      extendBody: true, // Crucial: lets the body extend behind the floating pill nav
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: const UniversalBottomNav(),
    );
  }
}