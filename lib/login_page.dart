import 'package:flutter/material.dart';
import 'main.dart'; // Import main.dart to navigate to MainScreen

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email", style: TextStyle(fontSize: 16)),
            TextField(controller: emailController),
            SizedBox(height: 16),
            Text("Password", style: TextStyle(fontSize: 16)),
            TextField(controller: passwordController, obscureText: true),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to MainScreen on successful login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
