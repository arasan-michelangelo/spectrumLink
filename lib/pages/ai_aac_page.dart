import 'package:flutter/material.dart';

class AIAccTab extends StatefulWidget {
  const AIAccTab({super.key});

  @override
  _AIAccTabState createState() => _AIAccTabState();
}

class _AIAccTabState extends State<AIAccTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Map<String, dynamic>> _aacPhrases = [
    {
      "category": "👋",
      "items": [
        {"text": "Hello", "icon": "assets/images/waving_hand.png"},
        {"text": "Goodbye", "icon": "assets/images/exit_to_app.webp"},
        {"text": "Thank you", "icon": "assets/images/thumb_up.webp"},
      ],
    },
    {
      "category": "🍎🥤",
      "items": [
        {"text": "Apple", "icon": "assets/images/apple.png"},
        {"text": "Bananas", "icon": "assets/images/bananas.png"},
        {"text": "Bread", "icon": "assets/images/bread.png"},
        {"text": "Butter", "icon": "assets/images/butter.png"},
        {"text": "Cereals", "icon": "assets/images/cereals.png"},
        {"text": "Chicken Leg", "icon": "assets/images/chicken-leg.png"},
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
          "text": "Strawberry Cake",
          "icon": "assets/images/strawberry-cake.png",
        },
        {"text": "Strawberry", "icon": "assets/images/strawberry.png"},
        {"text": "Vegetable", "icon": "assets/images/vegetable.png"},
        {"text": "Watermelon", "icon": "assets/images/watermelon.png"},
      ],
    },
    {
      "category": "🏃‍♂️👏",
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
      "category": "😊😢",
      "items": [
        {"text": "Sad", "icon": "assets/images/sentiment_dissatisfied.webp"},
        {"text": "Smile", "icon": "assets/images/smile.png"},
      ],
    },
    {
      "category": "🏠👨‍👩‍👦",
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
      "category": "⚠️🚫",
      "items": [
        {"text": "Error", "icon": "assets/images/error.webp"},
        {"text": "Fire", "icon": "assets/images/fire.webp"},
        {"text": "Question Mark", "icon": "assets/images/question_mark.webp"},
        {"text": "Voice Over Off", "icon": "assets/images/voice_over_off.png"},
        {"text": "Warning", "icon": "assets/images/warning.webp"},
      ],
    },
  ];
  late Map<String, List<Map<String, String>>> _categories;
  List<String> selectedPhrases = [];
  TextEditingController _textController = TextEditingController();
  String _selectedCategory = _aacPhrases.first['category'];

  @override
  void initState() {
    super.initState();

    // Extracting categories from _aacPhrases
    _categories = {
      for (var category in _aacPhrases)
        category['category']: List<Map<String, String>>.from(category['items']),
    };

    _tabController = TabController(length: _categories.length, vsync: this);
  }

  void _onPhraseTap(String phrase) {
    setState(() {
      selectedPhrases.add(phrase);
      _textController.text = selectedPhrases.join(" ");
    });
  }

  Future<void> _generateSentence() async {
    if (selectedPhrases.isEmpty) return;

    String generatedSentence =
        "Excuse me! I need help. Someone fainted on the road!";
    setState(() {
      _textController.text += " " + generatedSentence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Selected words appear here...",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _generateSentence,
                      ),
                    ),
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 400 ? 4 : 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _categories[_selectedCategory]?.length ?? 0,
                    itemBuilder: (context, index) {
                      var phrases = _categories[_selectedCategory]!;
                      return InkWell(
                        onTap: () => _onPhraseTap(phrases[index]['text']!),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                phrases[index]['icon']!,
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.error,
                                    size: 50,
                                    color: Colors.red,
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              Text(
                                phrases[index]['text']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Right-side Category List
          Container(
            width: 90, // Adjust width as needed
            color: Colors.transparent, // Transparent background
            child: ListView.builder(
              itemCount: _categories.keys.length,
              itemBuilder: (context, index) {
                String category = _categories.keys.elementAt(index);
                bool isSelected = _selectedCategory == category;

                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 4,
                  ), // Space between items
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Colors.blue.shade50
                            : Colors.transparent, // Highlight selected
                    borderRadius: BorderRadius.circular(12), // Curved border
                    border:
                        isSelected
                            ? Border.all(
                              color: Colors.blue,
                              width: 2,
                            ) // White border on active
                            : null,
                  ),
                  child: ListTile(
                    title: Text(
                      category,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            isSelected
                                ? Colors.white
                                : Colors
                                    .grey[300], // White on active, grey on inactive
                        fontWeight: FontWeight.w600,
                        fontSize:20,
                        
                      ),
                    ),
                    trailing:
                        isSelected
                            ? Container(
                              width: 5, // Thin vertical line
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            )
                            : null,
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
