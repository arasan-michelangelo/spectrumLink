import 'package:flutter/material.dart';

class AIAccTab extends StatelessWidget {
  const AIAccTab({super.key});

  static const List<Map<String, dynamic>> _aacPhrases = [
    {"text": "Hello", "icon": Icons.waving_hand},
    {"text": "Thank you", "icon": Icons.thumb_up},
    {"text": "Help", "icon": Icons.help},
    {"text": "Goodbye", "icon": Icons.exit_to_app},
    {"text": "Yes", "icon": Icons.check},
    {"text": "No", "icon": Icons.close},
    {"text": "Sorry", "icon": Icons.sentiment_dissatisfied},
    {"text": "I don't understand", "icon": Icons.question_mark},
    {"text": "Please", "icon": Icons.front_hand},
    {"text": "I need water", "icon": Icons.local_drink},
    {"text": "I'm hungry", "icon": Icons.restaurant},
    {"text": "Bathroom", "icon": Icons.wc},
    {"text": "I'm tired", "icon": Icons.bedtime},
    {"text": "Call for help", "icon": Icons.warning},
    {"text": "Where am I?", "icon": Icons.location_on},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 4 : 3; // 4 columns for tablets, 3 for phones

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          child: Text(
            "AAC Communication",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemCount: _aacPhrases.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("You tapped: ${_aacPhrases[index]['text']}"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  // Future: Add text-to-speech functionality here
                },
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _aacPhrases[index]['icon'],
                        size: 50,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _aacPhrases[index]['text'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
