import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  //get collection of generated sentences
  final CollectionReference inputCard=FirebaseFirestore.instance.collection('AAC_input'); //input collection
  final CollectionReference outputSentences=FirebaseFirestore.instance.collection('AAC_output'); //output collection


  //CREATE: add a new input_card
Future<void> createInputCard(List<String> selectedCards,currentTimestamp) async {
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



}