import 'package:flutter/material.dart';

class CameraMicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera / Mic"),
      ),
      body: Center(
        child: Text(
          "Camera and Mic Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
