import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
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
        title: const Text("Settings"),
        backgroundColor: Colors.blue.shade700,
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }

  Widget _buildListTile({required String title, required IconData icon, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
