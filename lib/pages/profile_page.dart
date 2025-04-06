import 'package:flutter/material.dart';
import '/pages/edit_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2, // Adds letter spacing for a modern look
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 10, // Adds a subtle shadow for better separation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 80, // Makes the AppBar taller
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEEE6FF), Color(0xFFD2E3FF)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Profile Content
            _buildProfileContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Picture and Info
        _buildProfileCard(),

        const SizedBox(height: 20),

        // Profile Details (Phone & Location)
        _buildProfileDetail(Icons.phone, 'Phone', '+123 456 7890'),
        _buildProfileDetail(Icons.location_on, 'Location', 'New York, USA'),

        const SizedBox(height: 30),

        // Edit Profile Button (Fixed Function Call)
        _buildEditButton(context),
      ],
    );
  }

  // Profile Card with Avatar, Name, and Email
  Widget _buildProfileCard() {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    shadowColor: Colors.black26,
    child: Padding(
      padding: const EdgeInsets.all(16.0),  // Adds padding inside the card
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://github.com/shadcn.png'),
          ),
          const SizedBox(height: 15),
          const Text(
            'Shaun Murphy',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            'shaun@example.com',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
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
        backgroundColor: Colors.blue.shade700, // Matching color to AppBar
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
