import 'package:flutter/material.dart';
import 'package:spectrum_link/pages/give_direction.dart';
import 'package:spectrum_link/pages/interview.dart';
import 'package:spectrum_link/pages/order_coffee.dart';
import 'package:spectrum_link/pages/small_talk.dart';


class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  double _trainingProgress = 0.3;

  final List<Map<String, dynamic>> _trainingScenarios = [
    {
      "title": "Ordering Coffee",
      "description": "Practice ordering a drink at a coffee shop.",
      "icon": Icons.local_cafe,
    },
    {
      "title": "Job Interview",
      "description": "Respond to common interview questions.",
      "icon": Icons.work,
    },
    {
      "title": "Asking for Directions",
      "description": "Practice asking and giving directions.",
      "icon": Icons.map,
    },
    {
      "title": "Small Talk",
      "description": "Engage in casual conversation with a stranger.",
      "icon": Icons.chat,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Training Mode", style: TextStyle(fontWeight: FontWeight.bold)),
      //   backgroundColor: Colors.blueAccent,
      //   elevation: 0,
      // ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEEE6FF), Color(0xFFD2E3FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _trainingProgress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                minHeight: 10,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Scenario Selection
            Expanded(
              child: ListView.builder(
                itemCount: _trainingScenarios.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showScenarioModal(context, _trainingScenarios[index]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent.withOpacity(0.2),
                          child: Icon(
                            _trainingScenarios[index]['icon'],
                            color: Colors.blueAccent,
                          ),
                        ),
                        title: Text(
                          _trainingScenarios[index]['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          _trainingScenarios[index]['description'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

 void _showScenarioModal(BuildContext context, Map<String, dynamic> scenario) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(scenario['icon'], size: 50, color: Colors.blueAccent),
            const SizedBox(height: 10),
            Text(
              scenario['title'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              scenario['description'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);

                // Routing logic based on scenario title
                Widget nextPage;
                switch (scenario['title']) {
                  case "Ordering Coffee":
                    nextPage = const OrderCoffeePage();
                    break;
                  case "Job Interview":
                    nextPage = const InterviewPage();
                    break;
                  case "Asking for Directions":
                    nextPage = const GiveDirectionPage();
                    break;
                  case "Small Talk":
                    nextPage = const SmallTalkPage();
                    break;
                  default:
                    return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Text("Start Training", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      );
    },
  );
}
}