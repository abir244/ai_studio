import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class StyleCardList extends StatelessWidget {
  const StyleCardList({super.key});

  final List<Map<String, String>> cards = const [
    {"name": "DreamLine", "image": "https://picsum.photos/id/10/200"},
    {"name": "SketchFlow", "image": "https://picsum.photos/id/20/200"},
    {"name": "Artify", "image": "https://picsum.photos/id/30/200"},
    {"name": "Portrait", "image": "https://picsum.photos/id/40/200"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: cards.map((card) => _buildStyleCard(card["name"]!, card["image"]!)).toList(),
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
}
