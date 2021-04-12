

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
  // Declare variables here

  final _formKey = GlobalKey<FormState>();
  String imgURL, questionnaireTitle, questionnaireDescription, questionnaireId;
  DatabaseService databaseService = new DatabaseService();

  bool _isloading = false;

  createQuestionnaire() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isloading = true;
      });

      questionnaireId = randomAlphaNumeric(16);

      //When defining a map, we have to define its value types
      //Here we have String key and a String value
      Map<String,String> questionnaireData = {
        "questionnaireId" : questionnaireId,
        "questionnaireDescription" : questionnaireDescription,
        "questionnaireTitle" : questionnaireTitle,
        "imgURL" : imgURL,
      };

      await databaseService.addQuestionnaireData(questionnaireData, questionnaireId).then((value){
        setState(() {
          _isloading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(
            //her. we pass the questionnaireID (it is needed to modify the questionnaire
            //when we add a question
            builder: (context) => AddQuestion(
             questionnaireId
            )
          ));
        });
      }
      );

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
      body: _isloading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :
      Form(
        key: _formKey,

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Image URL" : null,
              decoration: InputDecoration(
                hintText: "Questionnaire Image URL",
              ),
              onChanged: (val){
                imgURL = val;
              },
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Questionnaire Title" : null,
              decoration: InputDecoration(
                hintText: "Questionnaire Title",
              ),
              onChanged: (val){
                questionnaireTitle = val;
              },
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Questionnaire Description" : null,
              decoration: InputDecoration(
                hintText: "Questionnaire Description",
              ),
              onChanged: (val){
                questionnaireDescription = val;
              },
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                createQuestionnaire();
              },
                child: bicsBlueButton(context, "Create Questionnaire!")),
            SizedBox(height: 20,),

          ],),
        ),
      ),
    );
  }
}
