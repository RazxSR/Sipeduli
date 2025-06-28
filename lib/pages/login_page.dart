// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedEmail = prefs.getString('email');
    final String? storedPassword = prefs.getString('password');

    if (_emailController.text == storedEmail &&
        _passwordController.text == storedPassword) {
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Email or Password')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the height of the keyboard if it's open. This will be 0 if closed.
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // Get the top and bottom safe area insets (e.g., notch, status bar, home indicator)
    final topSafeArea = MediaQuery.of(context).padding.top;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      // Crucial: Set resizeToAvoidBottomInset to false. This prevents the Scaffold's
      // body from resizing when the keyboard appears, ensuring background globs stay fixed.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Layer: These Positioned widgets are direct children of the root Stack,
          // making them fixed relative to the entire screen.
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.8),
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.8),
                borderRadius: BorderRadius.circular(110),
              ),
            ),
          ),

          // Foreground Layer: This holds the main content (form).
          // Positioned.fill ensures this layer covers the entire screen space.
          Positioned.fill(
            child: LayoutBuilder(
              // Use LayoutBuilder to get the available size for the content
              builder: (context, constraints) {
                // Calculate the effective height for the content area, accounting for keyboard
                // and safe areas. This is the height the content Column will fill.
                final contentAreaHeight =
                    constraints.maxHeight -
                    keyboardHeight -
                    topSafeArea -
                    bottomSafeArea;

                return Padding(
                  // Apply padding to the main content area
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    // Explicitly size the content container
                    // Ensure the SizedBox takes at least the calculated contentAreaHeight.
                    // This is key for MainAxisAlignment.center to work correctly.
                    height: contentAreaHeight > 0 ? contentAreaHeight : 0,
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // Center content vertically within SizedBox
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _login,
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Google Sign-in not implemented yet!',
                                ),
                              ),
                            );
                          },
                          icon: Image.asset(
                            'assets/google_logo.png',
                            height: 24,
                          ),
                          label: const Text('Sign in with Google'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                              color: AppColors.primaryPurple,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Create Account?',
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppColors.primaryPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
