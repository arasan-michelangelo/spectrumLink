import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
            colors: [Color(0xFFEEE6FF), Color(0xFFD2E3FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              "Preferences",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            _buildSwitchTile(
              title: "Dark Mode",
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            _buildSwitchTile(
              title: "Enable Notifications",
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            const Divider(),
            const Text(
              "Account",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            _buildListTile(
              title: "Change Password",
              icon: Icons.lock,
              onTap: () {
                // Handle password change
              },
            ),
            _buildListTile(
              title: "Privacy Settings",
              icon: Icons.privacy_tip,
              onTap: () {
                // Handle privacy settings
              },
            ),
            const Divider(),
            const Text(
              "Support",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            _buildListTile(
              title: "Help & Support",
              icon: Icons.help_outline,
              onTap: () {
                // Navigate to help page
              },
            ),
            _buildListTile(
              title: "About App",
              icon: Icons.info_outline,
              onTap: () {
                // Show app details
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({required String title, required bool value, required Function(bool) onChanged}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Widget _buildListTile({required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade700),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }
}
