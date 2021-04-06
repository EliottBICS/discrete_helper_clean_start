import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //function used to pass some data to the firestore database

  Future<void> addQuestionnaireData(
      // In firestore, the couples key : value are called maps
      // This method will replace the data of the questionnaire with given ID
      // With the data provided
      //Here, data is loose term that means some keys and values couples
      Map questionnaireData,
      String questionnaireId) async {
    await FirebaseFirestore.instance
        .collection("Questionnaire")
        .doc(questionnaireId)
        .set(questionnaireData)
        .catchError((e) {
      print(e.toString());
    });
  }
}
