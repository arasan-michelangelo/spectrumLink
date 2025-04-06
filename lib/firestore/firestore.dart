import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Collections for order coffee chat
  //get collection of generated sentences
  final CollectionReference inputCard=FirebaseFirestore.instance.collection('AAC_input'); //input collection
  final CollectionReference outputSentences=FirebaseFirestore.instance.collection('AAC_output'); //output collection
  final CollectionReference orderCoffeeInput=FirebaseFirestore.instance.collection('ai_ordercoffee_input'); 
  final CollectionReference orderCoffeeOutput=FirebaseFirestore.instance.collection('ai_ordercoffee_output');
  final CollectionReference interviewInput=FirebaseFirestore.instance.collection('ai_interview_input'); 
  final CollectionReference interviewOutput=FirebaseFirestore.instance.collection('ai_interview_output');
  final CollectionReference giveDirectionInput=FirebaseFirestore.instance.collection('ai_giveDirection_input'); 
  final CollectionReference giveDirectionOutput=FirebaseFirestore.instance.collection('ai_giveDirection_output');
  final CollectionReference smallTalkInput=FirebaseFirestore.instance.collection('ai_smallTalk_input'); 
  final CollectionReference smallTalkOutput=FirebaseFirestore.instance.collection('ai_smallTalk_output');
  

  //CREATE: add a new input_card
  Future<void> createInputCard(List<String> selectedCards, currentTimestamp) async {
    // Ensure the list has exactly 5 slots, filling empty ones with an empty string
    List<String> filledCards = List.filled(5, ""); // Initialize with 5 empty strings

    for (int i = 0; i < selectedCards.length; i++) {
      filledCards[i] = selectedCards[i]; // Assign selected cards in order
    }

    await inputCard.add({
      'card_1': filledCards[0],
      'card_2': filledCards[1],
      'card_3': filledCards[2],
      'card_4': filledCards[3],
      'card_5': filledCards[4],
      'timestamp': currentTimestamp,
    });
  }

  //READ: get output from database
  Future<DocumentSnapshot?> getLatestOutputSentence() async {
    QuerySnapshot querySnapshot = await outputSentences
        .orderBy('timestamp', descending: true)
        .limit(1) // Fetch only the latest document
        .get();

    return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first : null;
  }

  Future<void> saveOrderCoffeeInput(String message, Timestamp timestamp) async {
    await orderCoffeeInput.add({
      'message': message,
      'timestamp': timestamp,
    });
  }

  // Get the latest AI response from Firestore
  Future<DocumentSnapshot?> getLatestOrderCoffeeOutput() async {
    QuerySnapshot querySnapshot = await orderCoffeeOutput
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first : null;
  }

  Future<void> saveInterviewInput(String message, Timestamp timestamp) async {
    await interviewInput.add({
      'message': message,
      'timestamp': timestamp,
    });
  }

  // Get the latest AI response from Firestore
  Future<DocumentSnapshot?> getLatestInterviewOutput() async {
    QuerySnapshot querySnapshot = await interviewOutput
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first : null;
  }
  Future<void> saveGiveDirectionInput(String message, Timestamp timestamp) async {
    await giveDirectionInput.add({
      'message': message,
      'timestamp': timestamp,
    });
  }

  // Get the latest AI response from Firestore
  Future<DocumentSnapshot?> getLatestGiveDirectionOutput() async {
    QuerySnapshot querySnapshot = await giveDirectionOutput
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first : null;
  }
  Future<void> saveSmallTalkInput(String message, Timestamp timestamp) async {
    await smallTalkInput.add({
      'message': message,
      'timestamp': timestamp,
    });
  }

  // Get the latest AI response from Firestore
  Future<DocumentSnapshot?> getLatestSmallTalkOutput() async {
    QuerySnapshot querySnapshot = await smallTalkOutput
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first : null;
  }

}

