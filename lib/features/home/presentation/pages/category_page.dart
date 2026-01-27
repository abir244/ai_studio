import 'package:flutter/material.dart';
import '../../../../core/routes/route_name.dart'; // Ensure this path is correct
import '../widgets/category_card.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column( // Changed to Column with Expanded ListView for better performance
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 30),
              const Text(
                "Discover",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CategoryCard(
                      title: "AI Art Generator",
                      subtitle: "Create stunning artwork with AI",
                      icon: Icons.brush_outlined,
                      backgroundColor: const Color(0xFFE8E8FF),
                      isSelected: true, // Matching Figma highlight
                      onTap: () => Navigator.pushNamed(context, RouteName.homepage),
                    ),
                    CategoryCard(
                      title: "AI Sketch",
                      subtitle: "Transform ideas into sketches",
                      icon: Icons.auto_fix_high_outlined,
                      backgroundColor: const Color(0xFFF5F0FF),
                      onTap: () => Navigator.pushNamed(context, RouteName.homepage),
                    ),
                    CategoryCard(
                      title: "AI Friend",
                      subtitle: "Chat with your AI companion",
                      icon: Icons.chat_bubble_outline,
                      backgroundColor: const Color(0xFFF0F5FF),
                      onTap: () => Navigator.pushNamed(context, RouteName.homepage),
                    ),

                    // Premium Card - Can also go to Home or a Subscription page
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RouteName.homepage),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF3F3D56)],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.stars, color: Colors.amber, size: 30),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Premium Features",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Download your creations in high quality",
                                    style: TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Alex",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Let's create something amazing",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const CircleAvatar(
          backgroundColor: Color(0xFFF0F0F0),
          child: Icon(Icons.person_outline, color: Colors.grey),
        )
      ],
    );
  }
}