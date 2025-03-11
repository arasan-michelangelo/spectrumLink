import 'package:flutter/material.dart';

// Home Page
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key to control the drawer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign key
      backgroundColor: Colors.grey[200],
      drawer: _buildSidebar(context), // Sidebar Drawer
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hello\nShaun Murphy',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer(); // Open sidebar
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/anaDeArmas.jpg'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search services',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Services
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.person, size: 40, color: Colors.green),
                  Icon(Icons.edit, size: 40, color: Colors.orange),
                  Icon(Icons.grid_view, size: 40, color: Colors.blue),
                  Icon(Icons.coronavirus, size: 40, color: Colors.purple),
                ],
              ),
              const SizedBox(height: 16),
              // To-Do List
              const Text(
                'ToDo-List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: const [
                    ToDoCard(
                      day: '12',
                      weekday: 'Tue',
                      time: '09:30 AM',
                      title: 'Class',
                      subtitle: 'Science Computer',
                      color: Colors.teal,
                    ),
                    ToDoCard(
                      day: '13',
                      weekday: 'Thur',
                      time: '09:40 AM',
                      title: 'Meeting',
                      subtitle: 'Asd Professional',
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sidebar Drawer
  Widget _buildSidebar(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/anaDeArmas.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Shaun Murphy',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'shaun@example.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Login Settings'),
            onTap: () {
              // Navigate to Login Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginSettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              _showSignOutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // Sign Out Confirmation Dialog
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login'); // Go back to Login Page
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Login Settings Page
class LoginSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Settings')),
      body: const Center(child: Text('Login settings go here')),
    );
  }
}

// ToDo Card Widget
class ToDoCard extends StatelessWidget {
  final String day;
  final String weekday;
  final String time;
  final String title;
  final String subtitle;
  final Color color;

  const ToDoCard({
    super.key,
    required this.day,
    required this.weekday,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.2),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$weekday, $time\n$subtitle'),
        isThreeLine: true,
      ),
    );
  }
}
