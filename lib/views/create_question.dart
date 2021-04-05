import 'package:discrete_helper_clean_start/services/database.dart';
import 'package:discrete_helper_clean_start/views/add_question.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

//used to create an online questionnaire


class CreateQuestion extends StatefulWidget {
  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {

  //Declare variables here

  final _formKey = GlobalKey<FormState>();
  String  questionnaireTitle, questionnaireDescription, imgURL, questionnaireId;
  DatabaseService databaseService = new DatabaseService();
  // underscore makes a variable private (accessible only in this .dart)
  bool _isLoading = false;

  createQuestionnaire() async {
    if(_formKey.currentState.validate()){

      //setState is used to update a variable and refresh it at the same time
      setState(() {
        _isLoading = true;
      });
      
      //generates the questionnaire ID randomly (16) chars
      questionnaireId = randomAlphaNumeric(16);

      //maps a key to a value, here QuestionnaireId to the randomly generated string
      Map<String, String> questionnaireMap = {
        "questionnaireId" : questionnaireId,
        "imgUrl" : imgURL,
        "questionnaireDescription" : questionnaireDescription,
        "questionnaireTitle" : questionnaireTitle,
      };

      //sends this data to firestore with the function defined in database.dart
      //then stop loading
      await databaseService.addQuestionnaireData(questionnaireMap, questionnaireId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestion()));
        });

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
      ),
      //if we are still loading, show the first container, otherwise, show the second
      body: _isLoading ? Container (
        child: Center(child: CircularProgressIndicator()),
      ) : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key : _formKey,
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter question title" : null,
                  decoration: InputDecoration(
                    hintText: "Questionnaire title",
                  ),
                  onChanged: (val){
                    questionnaireTitle = val;
                  },
                ),
                SizedBox(height: 6),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter a description" : null,
                  decoration: InputDecoration(
                    hintText: "Questionnaire Description",
                  ),
                  onChanged: (val){
                    questionnaireDescription = val;
                  },
                ),
                SizedBox(height: 6),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter url of img" : null,
                  decoration: InputDecoration(
                    hintText: "Questionnaire's picture (URL)",
                  ),
                  onChanged: (val){
                    imgURL = val;

                  },
                ),
                Spacer(),
                bicsBlueButton(context, "Create Questionnaire!"),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
