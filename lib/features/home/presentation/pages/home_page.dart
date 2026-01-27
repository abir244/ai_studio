import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String selectedRatio = '1:1';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Type your idea", style: AppTextStyles.h2),
            const SizedBox(height: 12),
            _buildPromptInput(),
            const SizedBox(height: 24),
            const Text("Aspect Ratio", style: AppTextStyles.h2),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildRatioBtn('1:1', Icons.crop_square),
                const SizedBox(width: 10),
                _buildRatioBtn('16:9', Icons.crop_16_9),
                const SizedBox(width: 10),
                _buildRatioBtn('9:16', Icons.stay_current_portrait),
              ],
            ),
            const SizedBox(height: 24),
            const Text("Selected Style", style: AppTextStyles.h2),
            const SizedBox(height: 12),
            _buildStyleDropdown(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Select Style", style: AppTextStyles.h2),
                Text("See all", style: AppTextStyles.linkText),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  _buildStyleCard("DreamLine", "https://picsum.photos/id/10/200"),
                  _buildStyleCard("SketchFlow", "https://picsum.photos/id/20/200"),
                  _buildStyleCard("Artify", "https://picsum.photos/id/30/200"),
                  _buildStyleCard("Portrait", "https://picsum.photos/id/40/200"),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildGenerateButton(),
            const SizedBox(height: 100), // Added padding for the floating nav
          ],
        ),
      ),
      extendBody: true, // Important for the floating transparent nav effect
      //bottomNavigationBar: _buildBottomNav(),
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
                Text("Pro", style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPromptInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.1)),
        boxShadow: AppColors.softShadow,
      ),
      child: TextField(
        maxLines: 4,
        style: AppTextStyles.bodyMain.copyWith(color: AppColors.textBlack),
        decoration: InputDecoration(
          hintText: "Describe what you want to create...\n(e.g., 'A majestic dragon flying over a futuristic city')",
          hintStyle: AppTextStyles.hintText,
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRatioBtn(String text, IconData icon) {
    bool isSelected = selectedRatio == text;
    return GestureDetector(
      onTap: () => setState(() => selectedRatio = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.selectedRatioGradient : null,
          color: isSelected ? null : AppColors.chipInactive,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? AppColors.white : AppColors.textBlack),
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

  Widget _buildStyleDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Realistic", style: AppTextStyles.bodyMain.copyWith(fontWeight: FontWeight.w600, color: AppColors.textBlack)),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _buildStyleCard(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.softShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(imageUrl, width: 85, height: 85, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildGenerateButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome, color: AppColors.white, size: 20),
            SizedBox(width: 10),
            Text("Generate Image", style: AppTextStyles.buttonLarge),
          ],
        ),
      ),
    );
  }

  // --- CUSTOM PILL NAVIGATION BAR ---

  Widget _buildCenterActionButton() {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 2),
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
        child: const Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}