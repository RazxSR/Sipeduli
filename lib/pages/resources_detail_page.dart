// lib/pages/resources_detail_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart';

class ResourcesDetailPage extends StatelessWidget {
  const ResourcesDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources'), centerTitle: true),
      body: SingleChildScrollView(
        // BouncingScrollPhysics provides a smoother, more natural scroll feel
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resource cards
            _buildResourceCard(
              context,
              'Feeling Overwhelmed',
              'Dr. Budi',
              'assets/overwhelmed.png',
            ),
            const SizedBox(height: 20),
            _buildResourceCard(
              context,
              'Calm to focus',
              'Dr. Raka',
              'assets/calm_focus.png',
            ),
            const SizedBox(height: 20),
            _buildResourceCard(
              context,
              'Quick stress relief',
              'Dr. Asep',
              'assets/stress_relief.png',
            ),
            const SizedBox(height: 30),
            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // Activity items
            _buildActivityItem(
              'You completed the \'Mindfulness\' module',
              Icons.check_circle_outline,
            ),
            _buildActivityItem(
              'New content available',
              Icons.notifications_none,
            ),
            _buildActivityItem(
              'You completed the \'Stress Management\' module',
              Icons.check_circle_outline,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat_with_professionals');
              },
              child: const Text('Seek Confidential Support'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a resource card
  Widget _buildResourceCard(
    BuildContext context,
    String title,
    String doctor,
    String imagePath,
  ) {
    // Wrapping the card in RepaintBoundary to potentially optimize repaints during scrolling.
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover, // Ensure image covers the area
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    doctor,
                    style: TextStyle(fontSize: 14, color: AppColors.darkGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an activity item
  Widget _buildActivityItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryPurple, size: 24),
          const SizedBox(width: 15),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
