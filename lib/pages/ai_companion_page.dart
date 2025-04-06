import 'package:flutter/material.dart';
import 'package:spectrum_link/pages/training_page.dart';
import 'package:spectrum_link/pages/ai_aac_page.dart';

class AICompanionPage extends StatefulWidget {
  const AICompanionPage({super.key});

  @override
  _AICompanionPageState createState() => _AICompanionPageState();
}

class _AICompanionPageState extends State<AICompanionPage> {
  int _selectedTab = 0; // 0: Training, 1: AAC

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEEE6FF), Color(0xFFD2E3FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Tabs Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 7,
                      ),
                      child: Row(
                        children: [
                          _buildTabButton("Training 📚", 0),
                          const SizedBox(width: 8),
                          _buildTabButton("AAC 🧠", 1),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        'https://github.com/shadcn.png',
                      ),
                    ),
                  ],
                ),

                // const SizedBox(height: 20),

                // AI Avatar
                // const CircleAvatar(
                //   radius: 80,
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage('https://github.com/shadcn.png'),
                // ),
                const SizedBox(height: 20),

                // Dynamic Page Content
                Expanded(
                  child: _selectedTab == 0 ? TrainingPage() : AIAccTab(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _selectedTab == index ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedTab == index ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
