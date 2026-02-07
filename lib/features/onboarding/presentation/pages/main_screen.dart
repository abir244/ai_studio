import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/universal_bottom_nav.dart';
import '../../../home/presentation/pages/category_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../home/viewmodel/navigation_provider.dart';
import '../../../chat/presentation/pages/chat_list_page.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    final pages = <Widget>[
      const HomePage(),               // 0
      const CategoryPage(),           // 1
      const Center(child: Text("Magic")), // 2
      const ChatListPage(),           // 3 ✅
      const Center(child: Text("Profile")), // 4
    ];

    final safeIndex = currentIndex.clamp(0, pages.length - 1);

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: safeIndex,
        children: pages,
      ),
      bottomNavigationBar: const UniversalBottomNav(),
    );
  }
}