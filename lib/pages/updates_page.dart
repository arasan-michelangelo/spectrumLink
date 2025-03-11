import 'package:flutter/material.dart';

class UpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFEEE6FF), Color(0xFFD2E3FF)], // Light purple to blue gradient
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "Updates & Notifications",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    "Stay updated with important alerts and announcements.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Notification Items
                  _buildNotificationItem(
                    title: "Emergency Alert",
                    subtitle: "Urgent: Please check the latest updates.",
                    time: "1m ago",
                    icon: Icons.warning_amber_rounded,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),

                  _buildNotificationItem(
                    title: "System Update",
                    subtitle: "A new software update is available.",
                    time: "10m ago",
                    icon: Icons.system_update,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),

                  _buildNotificationItem(
                    title: "AI Report",
                    subtitle: "Your latest AI analysis is ready to view.",
                    time: "30m ago",
                    icon: Icons.analytics,
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 16),

                  _buildNotificationItem(
                    title: "To-Do Reminder",
                    subtitle: "You have pending tasks for today.",
                    time: "3h ago",
                    icon: Icons.list_alt,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),

                  _buildNotificationItem(
                    title: "Reservation Confirmation",
                    subtitle: "Your booking is confirmed for 6 PM.",
                    time: "5h ago",
                    icon: Icons.calendar_today,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Notification Card (Glassmorphism Style)
  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Glass effect
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            radius: 30,
            child: Icon(icon, size: 32, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: TextStyle(color: Colors.black45, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
