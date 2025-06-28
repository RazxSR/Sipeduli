// lib/pages/chat_with_professionals_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart'; // Import custom colors

class ChatWithProfessionalsPage extends StatelessWidget {
  const ChatWithProfessionalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with professionals'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Our commitment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildCommitmentItem(Icons.lock, 'Confidential and secure'),
            _buildCommitmentItem(Icons.access_time, 'Real-time support'),
            _buildCommitmentItem(Icons.healing, 'No insurance needed'),
            _buildCommitmentItem(Icons.calendar_today, 'No waiting lists'),
            const SizedBox(height: 30),
            Text(
              'Chat History are Private and Anonymous',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGrey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your Information are safe and you're in control",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGrey,
              ),
            ),
            const SizedBox(height: 20),
            _buildCommitmentItem(
              Icons.check_circle_outline,
              'You can end the conversation at any time',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/chat_detail',
                ); // Navigate to a chat session
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitmentItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryPurple, size: 28),
          const SizedBox(width: 15),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}
