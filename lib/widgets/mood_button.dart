// lib/widgets/mood_button.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart'; // Ensure this import is correct

class MoodButton extends StatelessWidget {
  final int value;
  final bool isSelected; // New property to indicate if the button is selected

  const MoodButton({
    super.key,
    required this.value,
    this.isSelected = false, // Default to false if not provided
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        // Change color based on isSelected status
        color: isSelected ? AppColors.primaryPurple : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryPurple),
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // Change text color based on isSelected status
            color: isSelected ? Colors.white : AppColors.primaryPurple,
          ),
        ),
      ),
    );
  }
}
