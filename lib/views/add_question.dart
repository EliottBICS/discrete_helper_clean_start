import 'package:discrete_helper_clean_start/services/database.dart';
import 'package:discrete_helper_clean_start/widgets/BICSColors.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  //We will use this ID to refer to a specific questionnaire
  final String questionnaireId;
  AddQuestion(this.questionnaireId);



  @override
  _AddQuestionState createState() => _AddQuestionState();
}

//Here the user can create a new question and add it to the current Questionnaire

class _AddQuestionState extends State<AddQuestion> {

  //Creation of one text editing controller per field, in order to be able to
  //clear the fields automatically
  final intitulateHolder = TextEditingController();
  final option1Holder = TextEditingController();
  final option2Holder = TextEditingController();
  final option3Holder = TextEditingController();
  final option4Holder = TextEditingController();

  clearTextInput(){
    intitulateHolder.clear();
    option1Holder.clear();
    option2Holder.clear();
    option3Holder.clear();
    option4Holder.clear();
  }

  final _formkey = GlobalKey<FormState>();
  //For now, answer1 is the correct option
  String question, answer1, answer2, answer3, answer4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    //If the fields question and answer 1 to 4 are filled
    if(_formkey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });

      //the keys are always strings (obvious) and the values in this case are strings
      //as well (because of the nature of the data stored) (not obvious)
      Map<String, String> questionData = {
        "question" : question,
        "answer1" : answer1,//The good answer (we shuffle them afterwards)
        "answer2" : answer2,
        "answer3" : answer3,
        "answer4" : answer4,
      };
      // When the function addQuestionData has been properly executed, the loading is over
      await databaseService.addQuestionData(questionData, widget.questionnaireId)
      .then((value){
        setState(() {
          question = "";
          _isLoading = false;

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

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: intitulateHolder,
                validator: (val) => val.isEmpty ? "Enter an intitulate" : null,
                decoration: InputDecoration(
                  hintText: "Intitulate of your Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              TextFormField(
                controller: option1Holder,
                validator: (val) => val.isEmpty ? "Enter an answer 1" : null,
                decoration: InputDecoration(
                  hintText: "Option 1 (Answer)",
                ),
                onChanged: (val){
                  answer1 = val;
                },
              ),
              TextFormField(
                controller: option2Holder,
                validator: (val) => val.isEmpty ? "Enter an answer 2" : null,
                decoration: InputDecoration(
                  hintText: "Option 2",
                ),
                onChanged: (val){
                  answer2 = val;
                },
              ),
              TextFormField(
                controller: option3Holder,
                validator: (val) => val.isEmpty ? "Enter an answer 3" : null,
                decoration: InputDecoration(
                  hintText: "Option 3",
                ),
                onChanged: (val){
                  answer3 = val;
                },
              ),
              TextFormField(
                controller: option4Holder,
                validator: (val) => val.isEmpty ? "Enter an answer 4" : null,
                decoration: InputDecoration(
                  hintText: "Option 4",
                ),
                onChanged: (val){
                  answer4 = val;
                },
              ),
              Spacer(),
              //The use of a builder widget gives the context used by the snackbar
              Builder(
                builder: (context) => GestureDetector(
                  onTap: (){
                    //Uploads data to firestore
                    uploadQuestionData();
                    clearTextInput();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Question added to the database'),
                      duration: Duration(seconds: 3),
                    ));
                    },
                    child: bicsBlueButton(context, "Add this question")),
              ),
              SizedBox(height: 10,),
              Builder(
                builder: (context) =>GestureDetector(
                  onTap: () async {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Questionnaire added to the database'),
                      duration: Duration(seconds: 3),
                    ));
                    //Wait enough time to show the snackbar (and prevents spamming)
                    await Future.delayed(const Duration(seconds : 2),(){});
                    Navigator.pop(context);
                    },
                    child: bicsRedButton(context, "Submit")),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      )
    );
  }
}
