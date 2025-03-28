import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spectrum_link/firestore/firestore.dart';

String aiResponse = "";

Future<void> sendDataToBackend(List<String> selectedPhrases, Function(String) updateChat) async {
  final String url = "http://10.0.2.2:5000/process-aac"; // Local Testing

  if (selectedPhrases.isEmpty) return;

  Map<String, dynamic> requestData = {
    for (int i = 0; i < selectedPhrases.length; i++) "card_${i + 1}": selectedPhrases[i]
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      aiResponse = data["ai_generated_text"];
      if (aiResponse.isNotEmpty) updateChat(aiResponse);
    } else {
      print("Error.statusCode: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Request failed: $e");
  }
}

class AIAccTab extends StatefulWidget {
  const AIAccTab({super.key});

  static const List<Map<String, dynamic>> _aacPhrases = [
{
      "category": "👋 Greetings",
      "items": [
        {"text": "Hello", "icon": "assets/images/waving_hand.png"},
        {"text": "Goodbye", "icon": "assets/images/exit_to_app.webp"},
        {"text": "Thank you", "icon": "assets/images/thumb_up.webp"},
      ],
    },
    {
      "category": "🍎 Food & Drinks",
      "items": [
        {"text": "Apple", "icon": "assets/images/apple.png"},
        {"text": "Bananas", "icon": "assets/images/bananas.png"},
        {"text": "Bread", "icon": "assets/images/bread.png"},
        {"text": "Butter", "icon": "assets/images/butter.png"},
        {"text": "Cereals", "icon": "assets/images/cereals.png"},
        {"text": "Chicken ", "icon": "assets/images/chicken-leg.png"},
        {"text": "Coconut", "icon": "assets/images/coconut.png"},
        {"text": "Durian", "icon": "assets/images/durian.png"},
        {"text": "Egg", "icon": "assets/images/egg.png"},
        {"text": "Fish", "icon": "assets/images/fish.png"},
        {"text": "Grape", "icon": "assets/images/grape.png"},
        {"text": "Ice Cream", "icon": "assets/images/ice-cream.png"},
        {"text": "Lemon", "icon": "assets/images/lemon.png"},
        {"text": "Mango", "icon": "assets/images/mango.png"},
        {"text": "Milk", "icon": "assets/images/milk.png"},
        {"text": "Orange", "icon": "assets/images/orange.png"},
        {"text": "Papaya", "icon": "assets/images/papaya.png"},
        {"text": "Pineapple", "icon": "assets/images/pineapple.png"},
        {"text": "Ramen", "icon": "assets/images/ramen.png"},
        {"text": "Rice", "icon": "assets/images/rice.png"},
        {"text": "Soda", "icon": "assets/images/soda.png"},
        {"text": "Spaghetti", "icon": "assets/images/spaguetti.png"},
        {
          "text": "Cake",
          "icon": "assets/images/strawberry-cake.png",
        },
        {"text": "Strawberry", "icon": "assets/images/strawberry.png"},
        {"text": "Vegetable", "icon": "assets/images/vegetable.png"},
        {"text": "Watermelon", "icon": "assets/images/watermelon.png"},
      ],
    },
    {
      "category": "🏃‍♂️ Action",
      "items": [
        {"text": "Check", "icon": "assets/images/check.webp"},
        {"text": "Close", "icon": "assets/images/close.webp"},
        {"text": "Help", "icon": "assets/images/help.webp"},
        {"text": "Location On", "icon": "assets/images/location_on.webp"},
        {"text": "Map", "icon": "assets/images/map.png"},
        {"text": "Repeat", "icon": "assets/images/repeat.webp"},
        {"text": "Stop", "icon": "assets/images/stop.webp"},
        {"text": "Wave", "icon": "assets/images/wave.png"},
        {"text": "Write It", "icon": "assets/images/write_it.webp"},
      ],
    },
    {
      "category": "😊 Feelings",
      "items": [
        {"text": "Sad", "icon": "assets/images/sentiment_dissatisfied.webp"},
        {"text": "Smile", "icon": "assets/images/smile.png"},
      ],
    },
    {
      "category": "🏠 Places",
      "items": [
        {"text": "Boy", "icon": "assets/images/boy.png"},
        {"text": "Family", "icon": "assets/images/family.png"},
        {"text": "Local Hospital", "icon": "assets/images/local_hospital.webp"},
        {"text": "Restaurant", "icon": "assets/images/restaurant.webp"},
        {"text": "School", "icon": "assets/images/school.png"},
        {"text": "WC", "icon": "assets/images/wc.webp"},
      ],
    },
    {
      "category": "⚠️ Emergency",
      "items": [
        {"text": "Error", "icon": "assets/images/error.webp"},
        {"text": "Fire", "icon": "assets/images/fire.webp"},
        {"text": "Question Mark", "icon": "assets/images/question_mark.webp"},
        {"text": "Voice Over Off", "icon": "assets/images/voice_over_off.png"},
        {"text": "Warning", "icon": "assets/images/warning.webp"},
      ],
    },
  ];

  @override
  State<AIAccTab> createState() => _AIAccTabState();
}

class _AIAccTabState extends State<AIAccTab> {
  List<String> selectedPhrases = [];
  List<Map<String, dynamic>> _chatHistory = [];
  bool isMaxReached = false;
  late Map<String, List<Map<String, String>>> _categories;
  TextEditingController _textController = TextEditingController();
  TextEditingController _manualChatController = TextEditingController();
  String _selectedCategory = AIAccTab._aacPhrases.first['category'];

  @override
  void initState() {
    super.initState();
    _categories = {
      for (var category in AIAccTab._aacPhrases)
        category['category']: List<Map<String, String>>.from(category['items']),
    };
  }

  void addPhrase(String phrase) {
    if (selectedPhrases.length < 5) {
      setState(() {
        selectedPhrases.add(phrase);
        _textController.text = selectedPhrases.join(" ");
        isMaxReached = selectedPhrases.length == 5;
      });
    }
  }

  void sendToFirestore() async {
    if (selectedPhrases.isEmpty) return;

    Timestamp currentTimestamp = Timestamp.now();
    await FirestoreService().createInputCard(selectedPhrases, currentTimestamp);

    setState(() {
      _chatHistory.add({"sender": "User", "messages": List.from(selectedPhrases)});
      sendDataToBackend(selectedPhrases, updateChatHistory);
      selectedPhrases.clear();
      isMaxReached = false;
    });
  }

  void sendManualChat() {
    String userMessage = _manualChatController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _chatHistory.add({"sender": "User", "messages": [userMessage]});
      _manualChatController.clear();
    });

    sendDataToBackend([userMessage], updateChatHistory);
  }

  void updateChatHistory(String response) {
    setState(() {
      _chatHistory.add({"sender": "AI", "messages": [response]});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column( //Chat Box
      children: [
        Container(
          height: 250,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            children: _chatHistory.map((chat) {
              bool isUser = chat["sender"] == "User";
              return Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    isUser ? "You" : "AI Assistant",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isUser ? Colors.blue : Colors.green,
                    ),
                  ),
                  Column(
                    children: chat["messages"].map<Widget>((msg) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          msg,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  children: selectedPhrases.map((phrase) {
                    return Chip(
                      label: Text(phrase),
                      deleteIcon: Icon(Icons.close, size: 18, color: Colors.red),
                      onDeleted: () {
                        setState(() {
                          selectedPhrases.remove(phrase);
                          isMaxReached = false;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton.icon(
                onPressed: sendToFirestore,
                icon: const Icon(Icons.send),
                label: const Text("Send"),
              ),
            ],
          ),
        ),

        Expanded(
          child: Row( //Grid Icon Box
            children: [
              Expanded(
                flex: 3,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: _categories[_selectedCategory]?.length ?? 0,
                  itemBuilder: (context, index) {
                    var phrase = _categories[_selectedCategory]![index];
                    return InkWell(
                      onTap: () {
                        if (!isMaxReached) addPhrase(phrase['text']!);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(phrase['icon']!, width: 50, height: 50),
                          Text(phrase['text']!, textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Right-side Category List
              Container(
                width: 125,
                child: ListView.builder(
                  itemCount: _categories.keys.length,
                  itemBuilder: (context, index) {
                    String category = _categories.keys.elementAt(index);
                    List<String> words = category.split(" "); // Split category into words

                    return ListTile(
                      title: Column(
                        mainAxisSize: MainAxisSize.min, // Prevent unnecessary space
                        children: words.map((word) => Text(word, textAlign: TextAlign.center)).toList(),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
