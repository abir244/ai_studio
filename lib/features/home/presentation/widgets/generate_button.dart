import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodel/home_viewmodel.dart';

class GenerateButton extends ConsumerWidget {
  const GenerateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.isLoading
            ? null
            : () => ref.read(homeViewModelProvider.notifier).generateImage(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text("Generate Image", style: AppTextStyles.buttonLarge),
          ],
        ),
      ),
    );
  }
}
