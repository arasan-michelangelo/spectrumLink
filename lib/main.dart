import 'package:flutter/material.dart';
import 'login_page.dart';
import 'pages/home_page.dart';
import 'pages/ai_page.dart';
import 'pages/updates_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firestore/firebase_options.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MainScreen({super.key});

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
      backgroundColor: Colors.blue[700], // Main screen background
      body: _pages[_selectedIndex],

      // Notched Bottom AppBar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Color(0xFFD2E3FF), // Matches background
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0), // Horizontal padding added
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0), // Extra left padding
                child: IconButton(
                  icon: Icon(Icons.home, size: 30, color: _selectedIndex == 0 ? Colors.blue : Colors.black54),
                  onPressed: () => _onItemTapped(0),
                ),
              ),
              SizedBox(width: 40), // Space for FAB
              Padding(
                padding: const EdgeInsets.only(right: 10.0), // Extra right padding
                child: IconButton(
                  icon: Icon(Icons.update, size: 30, color: _selectedIndex == 2 ? Colors.blue : Colors.black54),
                  onPressed: () => _onItemTapped(2),
                ),
              ),
            ],
          ),
        ),
      ),

      // **Circular Floating Action Button for AI Page**
      floatingActionButton: Container(
        width: 70, // **Makes the FAB larger**
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent, // Ensures color consistency
          elevation: 0,
          child: Icon(Icons.android, size: 35, color: Colors.white), // **Larger AI icon**
          onPressed: () => _onItemTapped(1),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
