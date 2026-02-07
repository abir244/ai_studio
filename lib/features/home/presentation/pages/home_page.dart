import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/prompt_input.dart';
import '../widgets/aspect_ratio_selector.dart';
import '../widgets/style_dropdown.dart';
import '../widgets/style_card_list.dart';
import '../widgets/generate_button.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Type your idea", style: AppTextStyles.h2),
            SizedBox(height: 12),
            PromptInput(),
            SizedBox(height: 24),
            Text("Aspect Ratio", style: AppTextStyles.h2),
            SizedBox(height: 12),
            AspectRatioSelector(),
            SizedBox(height: 24),
            Text("Selected Style", style: AppTextStyles.h2),
            SizedBox(height: 12),
            StyleDropdown(),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Style", style: AppTextStyles.h2),
                Text("See all", style: AppTextStyles.linkText),
              ],
            ),
            SizedBox(height: 12),
            StyleCardList(),
            SizedBox(height: 32),
            GenerateButton(),
            SizedBox(height: 100),
          ],
        ),
      ),
      extendBody: true,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.scaffoldBg,
      centerTitle: false,
      leadingWidth: 65,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset(
          'assets/images/Frame.png',
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: AppColors.textBlack),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primaryPurple.withOpacity(0.3)),
            ),
            child: Row(
              children: const [
                Icon(Icons.stars, size: 16, color: AppColors.primaryPurple),
                SizedBox(width: 4),
                Text(
                  "Pro",
                  style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
