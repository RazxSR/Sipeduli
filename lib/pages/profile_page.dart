// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart'; // Ensure this import is correct
import 'package:sipeduli/pages/login_page.dart'; // Needed for navigation after logout
import 'package:shared_preferences/shared_preferences.dart'; // For local data storage
import 'package:image_picker/image_picker.dart'; // For picking images from gallery/camera
import 'dart:io'; // Essential for working with File objects

// This is the full page, used when navigating directly to Profile
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true),
      body: const ProfileContent(), // Use the public ProfileContent widget here
    );
  }
}

// This widget contains the editable profile content
class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _imageFile; // To store the selected profile image

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Load profile data when the widget initializes
  }

  // Method to load existing profile data from SharedPreferences
  Future<void> _loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? 'Guest User';
      _emailController.text = prefs.getString('email') ?? 'guest@example.com';
      final String? imagePath = prefs.getString('profileImagePath');
      if (imagePath != null) {
        _imageFile = File(imagePath); // If path exists, create File object
      }
    });
  }

  // Method to save profile data to SharedPreferences
  Future<void> _saveProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('email', _emailController.text);
    if (_imageFile != null) {
      await prefs.setString(
        'profileImagePath',
        _imageFile!.path,
      ); // Save image path
    }

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile Saved Successfully!')),
    );
  }

  // Method to pick a new profile image from the gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Update the image file
      });
    }
  }

  // Method to handle user logout
  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Set login status to false
    // Clear all stored profile data
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove(
      'password',
    ); // Important: In a real app, passwords should never be stored like this.
    await prefs.remove('profileImagePath');

    // Navigate back to the login page and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Purple header section, acting as the background for the profile image and text
          Container(
            color:
                AppColors
                    .primaryPurple, // Solid purple background for the header
            padding: const EdgeInsets.only(
              top: 40.0,
              bottom: 40.0,
            ), // Padding inside the purple box
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment:
                        Alignment
                            .center, // Ensure children of this Stack are centered
                    children: [
                      // The main profile image CircleAvatar
                      CircleAvatar(
                        radius: 60,
                        // Use FileImage if _imageFile is not null, otherwise use AssetImage placeholder
                        backgroundImage:
                            _imageFile != null
                                ? FileImage(_imageFile!)
                                    as ImageProvider<
                                      Object
                                    > // Explicit cast is needed for type safety
                                : const AssetImage(
                                  'assets/profile_pic.png',
                                ), // Placeholder image asset
                        backgroundColor:
                            AppColors.lightGrey, // Fallback background color
                      ),
                      // Positioned camera icon for picking image
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap:
                              _pickImage, // Call _pickImage when camera icon is tapped
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPurple,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10), // Space between image and text
                const Text(
                  'Edit Profil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500, // Medium weight
                    color:
                        Colors
                            .white, // White text on purple background, as per image
                  ),
                ),
              ],
            ),
          ),
          // Rest of the form content below the purple header
          Padding(
            padding: const EdgeInsets.all(24.0), // Padding for the form fields
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 1), // Space after purple header
                const Text(
                  'Username',
                  style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _saveProfile, // Call _saveProfile on button press
                  child: const Text('Save'),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: _logout, // Call _logout on button press
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryPurple,
                    side: const BorderSide(color: AppColors.primaryPurple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
