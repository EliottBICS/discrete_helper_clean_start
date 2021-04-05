import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  //function used to pass some data to the firestore database

  Future<void> addQuestionnaireData(Map questionnaireData, String questionnaireId) async {
    await FirebaseFirestore.instance.collection("Questionnaire")
        .doc(questionnaireId).set(questionnaireData)
        .catchError((e){print(e.toString());
        });



}