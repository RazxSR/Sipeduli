// lib/main.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart'; // Corrected import
import 'package:sipeduli/pages/landing_page.dart'; // Corrected import
import 'package:sipeduli/pages/login_page.dart'; // Corrected import
import 'package:sipeduli/pages/register_page.dart'; // Corrected import
import 'package:sipeduli/pages/home_page.dart'; // Corrected import
import 'package:sipeduli/pages/chat_with_professionals_page.dart'; // Corrected import
import 'package:sipeduli/pages/chat_page.dart'; // Corrected import
import 'package:sipeduli/pages/mood_log_page.dart'; // Corrected import
import 'package:sipeduli/pages/profile_page.dart'; // Corrected import
import 'package:sipeduli/pages/resources_detail_page.dart'; // Corrected import
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiPeduli App',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(
        primarySwatch:
            MaterialColor(AppColors.primaryPurple.value, const <int, Color>{
              50: Color(0xFFEBE3F0),
              100: Color(0xFFCCC0D8),
              200: Color(0xFFAAA0C0),
              300: Color(0xFF887FAD),
              400: Color(0xFF6E639A),
              500: AppColors.primaryPurple,
              600: Color(0xFF531681),
              700: Color(0xFF491275),
              800: Color(0xFF400E6A),
              900: Color(0xFF300858),
            }),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter', // Re-added the Inter font
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryPurple),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primaryPurple,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
      initialRoute: _isLoggedIn ? '/home' : '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/chat_with_professionals':
            (context) => const ChatWithProfessionalsPage(),
        '/chat_detail': (context) => const ChatPage(),
        '/mood_log': (context) => const MoodLogPage(),
        '/profile': (context) => const ProfilePage(),
        '/resources_detail': (context) => const ResourcesDetailPage(),
      },
    );
  }
}
