import 'package:flutter/material.dart';
import 'ai_companion_page.dart'; // Import AI Companion Page
import 'camera_mic_page.dart'; // Import Camera/Mic Page

class AIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artificial Intelligence"),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Companion Section (Clickable)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AICompanionPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.smart_toy, size: 40, color: Colors.blue),
                    SizedBox(width: 10),
                    Text("AI Companion", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Camera/Mic Section (Clickable)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraMicPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, size: 40, color: Colors.green),
                    SizedBox(width: 10),
                    Text("Camera / Mic", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // // Reservation Section
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.purple[100],
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   padding: EdgeInsets.all(16),
            //   child: Row(
            //     children: [
            //       Icon(Icons.calendar_today, size: 40, color: Colors.purple),
            //       SizedBox(width: 10),
            //       Text("Reservation with ASD Professional", style: TextStyle(fontSize: 16)),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
