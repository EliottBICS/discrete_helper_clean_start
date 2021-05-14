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

  //function used to create a user in the database

  Future<void> addUser( //Currently it gives an ID to the scoreList, which we do not use.
      //Nonetheless, if we want to add some other data to the users that is not related to its score, it
      //is possible with this database architecture
    Map userData,
    String userID,
  ) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .collection("Scores")
        .add(userData)
        // .set(userData)
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

  fetchUsers() async {
    return await FirebaseFirestore.instance.collection("Users").snapshots();
    //this function queries the current state of the collection "Users"
  }

  getUserData(String userID) async {
    //This returns keys and values of the data stored for each user
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .collection("Scores")
        .get();
  }

  fetchQuestionnaires() async {
    //this function querries the content of the Questionnaire collection
    //A snapshot is a state of the collection at some point in time
    return await FirebaseFirestore.instance
        .collection("Questionnaire")
        .snapshots();
  }

  getQuestionData(String questionnaireId) async {
    //This goes into the database and fetch every documents in the "Questions and Answers" collection of a specific questionnaire
    return await FirebaseFirestore.instance
        .collection("Questionnaire")
        .doc(questionnaireId)
        .collection("QnA")
        .get();
  }
}

