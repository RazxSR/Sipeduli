// lib/pages/landing_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart'; // Import custom colors
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Future.delayed(const Duration(seconds: 3), () { // Mengurangi delay agar lebih cepat
      if (mounted) {
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensure white background
      body: Stack(
        children: [
          // Top-right organic shape (from your SplashScreen code, with slight rotation for organic feel)
          Positioned(
            top: -50,
            right: -50,
            child: Transform.rotate(
              angle: 0.1, // Slight rotation for organic look
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple,
                  borderRadius: BorderRadius.circular(
                    75,
                  ), // Half of width/height for circular
                ),
              ),
            ),
          ),
          // Mid-left organic shape (from previous iteration, matching design)
          Positioned(
            top: 100,
            left: -80, // Moved slightly left to match the image more closely
            child: Transform.rotate(
              angle: -0.2, // Slight rotation
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(
                    100,
                  ), // Half of width/height for circular
                ),
              ),
            ),
          ),
          // Bottom-left organic shape (from your SplashScreen code, with slight rotation for organic feel)
          Positioned(
            bottom: -50,
            left: -50,
            child: Transform.rotate(
              angle: -0.3, // Slight rotation
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(
                    100,
                  ), // Keeping your specified radius
                ),
              ),
            ),
          ),
          // Bottom-right organic shape (from your SplashScreen code, with slight rotation for organic feel)
          Positioned(
            bottom: 100,
            right: -70,
            child: Transform.rotate(
              angle: -0.4, // Slight rotation
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(
                    80,
                  ), // Keeping your specified radius
                ),
              ),
            ),
          ),

          // Main content (SiPeduli text and yellow curve)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Default color for "Si"
                    ),
                    children: [
                      const TextSpan(text: 'Si'),
                      TextSpan(
                        text: 'Peduli',
                        style: TextStyle(
                          color:
                              AppColors
                                  .primaryPurple, // "Peduli" text in primary purple
                        ),
                      ),
                    ],
                  ),
                ),
                // Curved yellow line
                CustomPaint(
                  size: const Size(250, 50), // Canvas size for the line
                  painter: YellowCurvePainter(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter to draw the curved yellow line
class YellowCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color =
              AppColors
                  .accentYellow // Using your accent yellow color
          ..strokeWidth = 5.0
          ..style = PaintingStyle.stroke;

    final path = Path();
    // Start point adjusted to appear under "Peduli" text
    path.moveTo(size.width * 0.25, size.height * 0.6);

    // Create a curve upwards from left to right
    path.quadraticBezierTo(
      size.width * 0.5, // Control point X (middle of CustomPaint canvas)
      size.height * 0.05, // Control point Y (smaller value for upward curve)
      size.width * 0.9, // End point X (extended slightly to the right)
      size.height * 0.1, // End point Y (10% from top of canvas)
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}