import 'package:flutter/material.dart';
import 'dart:math';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  final List<String> healthTips = const [
    "Drink plenty of water and take regular breaks from screen time.",
    "Get at least 7-8 hours of sleep every night.",
    "Stay active! A short walk can improve your heart health.",
    "Maintain a balanced diet with fresh fruits and vegetables.",
    "Practice deep breathing exercises to reduce stress.",
  ];

  @override
  Widget build(BuildContext context) {
    final String randomTip = healthTips[Random().nextInt(healthTips.length)];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Your Health Overview",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Stay updated with your health status.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Health Stats Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: healthData.length,
              itemBuilder: (context, index) {
                return _buildHealthCard(
                  title: healthData[index]["title"],
                  value: healthData[index]["value"],
                  icon: healthData[index]["icon"],
                  color: healthData[index]["color"],
                );
              },
            ),

            // Health Tip Section
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "💡 Health Tip of the Day:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    randomTip,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Health Card Widget
  Widget _buildHealthCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// Dummy Health Data
final List<Map<String, dynamic>> healthData = [
  {
    "title": "Heart Rate",
    "value": "72 BPM",
    "icon": Icons.favorite,
    "color": Colors.red,
  },
  {
    "title": "Steps",
    "value": "8,500",
    "icon": Icons.directions_walk,
    "color": Colors.green,
  },
  {
    "title": "Calories",
    "value": "2,100 kcal",
    "icon": Icons.local_fire_department,
    "color": Colors.orange,
  },
  {
    "title": "Sleep",
    "value": "7h 30m",
    "icon": Icons.nightlight_round,
    "color": Colors.blue,
  },
];
