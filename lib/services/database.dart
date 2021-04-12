import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //Here are the functions used to pass some data to the firestore database

  //function used to create a questionnaire

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

  //function used to add a question to the database

  Future<void> addQuestionData(Map questionData, String questionnaireId) async {
    //In the Questionnaire collection, add the data in the document that has
    //the ID of the questionnaire we are editing
    await FirebaseFirestore.instance
        .collection("Questionnaire")
        .doc(questionnaireId)
        .collection("QnA") //QuestionsAndAnswers
        .add(questionData)
        .catchError((e) {
      //if an error is encountered, catch it
      print(e);
    });
  }
}
