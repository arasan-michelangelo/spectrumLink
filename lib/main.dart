import 'package:flutter/material.dart';
import 'login_page.dart';
import 'pages/home_page.dart';
import 'pages/ai_page.dart';
import 'pages/updates_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/main': (context) => MainScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5DC), // Beige background
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AIPage(),
    UpdatesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blue[700], // Blue background for the main screen
    body: _pages[_selectedIndex],

    bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.android), label: 'AI'),
        BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Updates'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      backgroundColor: Color(0xFFD2E3FF), // Makes the navbar transparent
      elevation: 0, // Removes shadow to fully blend with background
      onTap: _onItemTapped,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w900), // Bold selected text
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w900), // Bold unselected text
    ),
  );
}
}