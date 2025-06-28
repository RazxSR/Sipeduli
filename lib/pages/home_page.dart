// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart';
// Import the content widgets directly, as they are now public
import 'package:sipeduli/pages/mood_log_page.dart'; // Import MoodLogPage to access MoodLogContent
import 'package:sipeduli/pages/profile_page.dart'; // Import ProfilePage to access ProfileContent

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Use the now public content widgets for the bottom navigation bar tabs
  static final List<Widget> _widgetOptions = <Widget>[
    _HomeContent(), // Content for Home tab
    const MoodLogContent(), // Corrected: No underscore, use public MoodLogContent
    const ProfileContent(), // Corrected: No underscore, use public ProfileContent
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'SiPeduli'
              : (_selectedIndex == 1
                  ? 'Mood Log'
                  : 'Edit Profile'), // Dynamic title
          style: const TextStyle(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // Removed the 'actions' property entirely to remove both icons
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.construction,
            ), // Using a generic tool icon for 'Tools'
            label: 'Tools',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Content for the Home tab within HomePage
class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Get support',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/chat_with_professionals');
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Resources',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Resources grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildResourceItem(
                context,
                'Anxiety',
                'assets/stress_anxiety.png',
                () => Navigator.pushNamed(
                  context,
                  '/resources_detail',
                ), // Tetap ke resources_detail
              ),
              _buildResourceItem(
                context,
                'Depression',
                'assets/depression.png',
                () => Navigator.pushNamed(
                  context,
                  '/resources_detail',
                ), // Tetap ke resources_detail
              ),
              _buildResourceItem(
                context,
                'Sleep trouble',
                'assets/sleep_trouble.png',
                () => Navigator.pushNamed(
                  context,
                  '/resources_detail',
                ), // Tetap ke resources_detail
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Self-help tools',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Self-help tools grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildToolItem(
                context,
                'Calm mind',
                'assets/calm_mind.png',
                null,
              ),
              _buildToolItem(
                context,
                'Improve sleep',
                'assets/improve_sleep.png',
                null,
              ),
              _buildToolItem(
                context,
                'Mood tracker',
                'assets/mood_tracker.png',
                null, // Changed from '/mood_log' to null
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Recent Activities',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primaryPurple,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "You've been active 1 weeks in a row. Keep it up! 💪",
                    style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceItem(
    BuildContext context,
    String title,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(imagePath, height: 60, width: 60),
          const SizedBox(height: 8),
          Flexible( // Added Flexible here
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem(
    BuildContext context,
    String title,
    String imagePath,
    String? routeName,
  ) {
    return GestureDetector(
      onTap: () {
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Column(
        children: [
          Image.asset(imagePath, height: 60, width: 60),
          const SizedBox(height: 8),
          Flexible( // Added Flexible here
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
