import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_helper_clean_start/models/question.dart';
import 'package:discrete_helper_clean_start/services/database.dart';
import 'package:discrete_helper_clean_start/widgets/fill_questionnaire_widgets.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FillQuestionnaire extends StatefulWidget {

  final String questionnaireId;
  //constructor
  FillQuestionnaire(this.questionnaireId);



  @override
  _FillQuestionnaireState createState() => _FillQuestionnaireState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _FillQuestionnaireState extends State<FillQuestionnaire> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnapshot;

  Question fetchQuestionFromSnapshot(DocumentSnapshot questionSnapshot){

    Question question = new Question();

    question.intitulate = questionSnapshot.data()["question"]; //Unsure if I get the good data

    List<String> options =
        [questionSnapshot.data()["option1"],
          questionSnapshot.data()["option2"],
          questionSnapshot.data()["option3"],
          questionSnapshot.data()["option4"],

        ];

    //shuffle the options

    options.shuffle();

    question.option1 = options[0];
    question.option2 = options[1];
    question.option3 = options[2];
    question.option3 = options[3];
    question.goodAnswer = questionSnapshot.data()["option1"];
    //in order to prevent picking each and every option one after the other to check if they are good
    question.answered = false;
  }


  @override
  void initState() {
    print("This questionnaire's ID is ${widget.questionnaireId}");
    databaseService.fetchQuestions(widget.questionnaireId).then((value){
      questionSnapshot = value;
      print("here");
      _notAttempted;
      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot.docs.length;


      setState(() {


      });
      print("the length of the questionnaire is ${total}");
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
      ),
      body: Container(
        child: Column(children: [
          questionSnapshot.docs == null ?
              Container()
          :
              Container(child: ListView.builder(
                shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: questionSnapshot.docs.length,
                itemBuilder: (context, index){
                    return QuestionDisplayed(
                      question: fetchQuestionFromSnapshot(questionSnapshot.docs[index],),
                      index: index,//Unsure about "questionSnapshot"
                    );
                },
              ),)

        ],),
      ),
    );
  }
}

class QuestionDisplayed extends StatefulWidget {
  final Question question;
  final int index;
  
  QuestionDisplayed({@required this.question, @required this.index});
  
  
  @override
  _QuestionDisplayedState createState() => _QuestionDisplayedState();
}

class _QuestionDisplayedState extends State<QuestionDisplayed> {

  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.question.intitulate),
          SizedBox(height: 4,),
          PotentialAnswer(
            goodAnswer: widget.question.option1,
            description: widget.question.option1,
            label: "A",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4,),
          PotentialAnswer(
            goodAnswer: widget.question.option1,
            description: widget.question.option2,
            label: "B",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4,),
          PotentialAnswer(
            goodAnswer: widget.question.option1,
            description: widget.question.option3,
            label: "C",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4,),
          PotentialAnswer(
            goodAnswer: widget.question.option1,
            description: widget.question.option4,
            label: "D",
            optionSelected: optionSelected,
          ),
        ],
      ),
    );
  }
}
