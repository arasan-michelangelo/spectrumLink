import 'package:flutter/material.dart';
import 'dart:ui';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String name = "Shaun Murphy";
  String email = "shaun@example.com";
  String phone = "+1234567890";
  String location = "New York, USA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFDEEAFD), Color(0xFFFAFAFA)],
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.15),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Profile Picture
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage('https://github.com/shadcn.png'),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                                  onPressed: () {
                                    // Action to update profile picture
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Input Fields
                          _buildTextField('Full Name', name, Icons.person, (value) {
                            if (value == null || value.isEmpty) return 'Please enter your name';
                            return null;
                          }, (value) => name = value!),
                          _buildTextField('Email', email, Icons.email, (value) {
                            if (value == null || value.isEmpty || !value.contains('@')) return 'Enter a valid email';
                            return null;
                          }, (value) => email = value!),
                          _buildTextField('Phone', phone, Icons.phone, (value) {
                            if (value == null || value.isEmpty) return 'Enter a valid phone number';
                            return null;
                          }, (value) => phone = value!),
                          _buildTextField('Location', location, Icons.location_on, null, (value) => location = value!),

                          const SizedBox(height: 30),

                          // Animated Save Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Profile Updated!')),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                elevation: 8,
                                shadowColor: Colors.black26,
                              ),
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Input Field Widget
  Widget _buildTextField(
    String label,
    String initialValue,
    IconData icon,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          filled: true,
          fillColor: Colors.white.withOpacity(0.85),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
