import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodel/home_viewmodel.dart';

final List<String> artStyles = [
  "Realistic",
  "Oil Painting",
  "Abstract",
  "Digital Art",
  "Watercolor",
  "Sketch",
];

class StyleDropdown extends ConsumerWidget {
  const StyleDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.selectedStyle,
          dropdownColor: AppColors.surfaceGrey,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
          style: AppTextStyles.bodyMain.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
          items: artStyles
              .map((style) => DropdownMenuItem(value: style, child: Text(style)))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              ref.read(homeViewModelProvider.notifier).setStyle(value);
            }
          },
        ),
      ),
    );
  }
}
