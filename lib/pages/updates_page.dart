import 'package:flutter/material.dart';

class UpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationItem("Emergency", "Lorem ipsum dolor sit amet...", "1m ago", Colors.red),
            _buildNotificationItem("Disclaimer", "Lorem ipsum dolor sit amet...", "1m ago", Colors.blue),
            _buildNotificationItem("AI Report", "Lorem ipsum dolor sit amet...", "10m ago", Colors.grey),
            _buildNotificationItem("ToDo-List", "Lorem ipsum dolor sit amet...", "10hrs ago", Colors.green),
            _buildNotificationItem("Reservation Reminder", "Lorem ipsum dolor sit amet...", "15hrs ago", Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time, Color iconColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(Icons.notifications, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Text(time),
      ),
    );
  }
}
