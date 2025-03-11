import 'package:flutter/material.dart';

class AICompanionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Companion"),
      ),
      body: Center(
        child: Text(
          "Welcome to AI Companion!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
