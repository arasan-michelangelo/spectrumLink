import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spectrum_link/firestore/firestore.dart';

String aiResponse = "";

Future<void> sendDataToBackend(String userMessage, void Function(String) updateChat) async {
  final String url = "https://smalltalk-35139598673.us-central1.run.app/smalltalk_chatbot"; 

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"ai_input": userMessage}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseText = data["ai_generated_text"] as String?;
      if (responseText != null && responseText.isNotEmpty) {
        updateChat(responseText);
      } else {
        updateChat("I'm sorry, I couldn't process your request.");
      }
    } else {
      updateChat("Error ${response.statusCode}: ${response.body}");
    }
  } catch (e) {
    updateChat("Request failed: $e");
  }
}

class SmallTalkPage extends StatefulWidget {
  const SmallTalkPage({super.key});

  @override
  State<SmallTalkPage> createState() => _SmallTalkPageState();
}

class _SmallTalkPageState extends State<SmallTalkPage> {
  final List<Map<String, dynamic>> _chatHistory = [];
  final TextEditingController _messageController = TextEditingController();

  void sendMessage() {
    String userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _chatHistory.add({"sender": "User", "messages": [userMessage]});
      _messageController.clear();
    });

    sendDataToBackend(userMessage, updateChatHistory);
  }

  void updateChatHistory(String response) {
    setState(() {
      _chatHistory.add({"sender": "AI", "messages": [response]});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Small Talk Practice'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Chat History
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _chatHistory.length,
                itemBuilder: (context, index) {
                  final message = _chatHistory[index];
                  final isUser = message['sender'] == 'User';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        (message['messages'] as List).join(' '),
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Message Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: sendMessage,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

