import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodel/home_viewmodel.dart';

class AspectRatioSelector extends ConsumerWidget {
  const AspectRatioSelector({super.key});

  final List<Map<String, dynamic>> ratios = const [
    {'text': '1:1', 'icon': Icons.crop_square},
    {'text': '4:3', 'icon': Icons.crop_square},
    {'text': '16:9', 'icon': Icons.crop_16_9},
    {'text': '9:16', 'icon': Icons.stay_current_portrait},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: ratios
          .map(
            (ratio) => _buildRatioBtn(
          ratio['text'],
          ratio['icon'],
          state.selectedAspectRatio,
          ref,
        ),
      )
          .toList(),
    );
  }

  Widget _buildRatioBtn(String text, IconData icon, String selectedRatio, WidgetRef ref) {
    bool isSelected = selectedRatio == text;

    return GestureDetector(
      onTap: () => ref.read(homeViewModelProvider.notifier).setAspectRatio(text),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.selectedRatioGradient : null,
          color: isSelected ? null : AppColors.chipInactive,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: isSelected ? AppColors.white : AppColors.textBlack),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTextStyles.chipText.copyWith(
                color: isSelected ? AppColors.white : AppColors.textBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
