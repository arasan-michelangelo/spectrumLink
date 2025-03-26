import 'package:flutter/material.dart';
import 'dart:ui';
import '/pages/edit_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFEEE6FF), Color(0xFFD2E3FF)],
              ),
            ),
          ),

          // Profile Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Card with Glassmorphic Effect
                  _buildGlassmorphicCard(),

                  const SizedBox(height: 20),

                  // User Details (Phone & Location)
                  _buildProfileDetail(Icons.phone, 'Phone', '+123 456 7890'),
                  _buildProfileDetail(Icons.location_on, 'Location', 'New York, USA'),

                  const SizedBox(height: 30),

                  // Edit Profile Button (Fixed Function Call)
_buildEditButton(context), // Pass context here

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Glassmorphic Profile Card
  Widget _buildGlassmorphicCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(color: Colors.black26.withOpacity(0.2), blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Column(
            children: [
              // Profile Picture
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://github.com/shadcn.png'),
              ),
              const SizedBox(height: 15),

              // User Name & Email
              const Text(
                'Shaun Murphy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Text(
                'shaun@example.com',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Detail Card
  Widget _buildProfileDetail(IconData icon, String label, String value) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.black26,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade800, size: 30),
        title: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        subtitle: Text(label, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

// Edit Profile Button with Ripple Effect
Widget _buildEditButton(BuildContext context) {
  return ElevatedButton.icon(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditProfilePage()), // Navigate to EditProfilePage
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      elevation: 8,
      shadowColor: Colors.black45,
    ),
    icon: const Icon(Icons.edit, color: Colors.white),
    label: const Text(
      'Edit Profile',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
}


}
