import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodel/home_viewmodel.dart';

class PromptInput extends ConsumerWidget {
  const PromptInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.1)),
        boxShadow: AppColors.softShadow,
      ),
      child: TextField(
        maxLines: 4,
        onChanged: (value) => ref.read(homeViewModelProvider.notifier).setPrompt(value),
        style: AppTextStyles.bodyMain.copyWith(color: AppColors.textBlack),
        decoration: InputDecoration(
          hintText:
          "Describe what you want to create...\n(e.g., 'A majestic dragon flying over a futuristic city')",
          hintStyle: AppTextStyles.hintText,
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
