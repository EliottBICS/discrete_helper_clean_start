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
  QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionModelFromSnapshot(DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();

    if(questionSnapshot != null){
      print("Snapshot exists");
      print(questionSnapshot);
    }

    questionModel.question = questionSnapshot.data()["question"];
    //"Hello";

        //questionsSnapshot.data()[""]; //Unsure if I get the good data

    List<String> options =
        [questionSnapshot.data()["answer1"],
          questionSnapshot.data()["answer2"],
          questionSnapshot.data()["answer3"],
          questionSnapshot.data()["answer4"],

        ];

    // List<String> options =
    // ["option1",
    //   "option2",
    //  "option3",
    //   "option4",
    // ];

    //shuffle the options

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data()["answer1"];
    //questionModel.correctOption = "option1";
    //in order to prevent picking each and every option one after the other to check if they are good
    questionModel.answered = false;

    print(questionModel.option1);
    print(questionModel.option2);
    print(questionModel.option3);
    print(questionModel.option4);

    return questionModel;
  }


  @override
  void initState() {
    print("This questionnaire's ID is ${widget.questionnaireId}");
    databaseService.getQuestionData(widget.questionnaireId).then((value){
      questionsSnapshot = value;
      print("here");
      _notAttempted;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.docs.length;


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
          questionsSnapshot.docs == null ?
              Container()
          :
              Container(child: ListView.builder(
                shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: questionsSnapshot.docs.length,
                itemBuilder: (context, index){
                    return QuizPlayTile(
                      questionModel: getQuestionModelFromSnapshot(questionsSnapshot.docs[index],),
                      index: index,//Unsure about "questionSnapshot"
                    );
                },
              ),)

        ],),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  
  QuizPlayTile({@required this.questionModel, @required this.index});
  
  
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.questionModel.question),
          SizedBox(height: 4,),
          OptionTile(
            goodAnswer: widget.questionModel.option1,
            description: widget.questionModel.option1,
            label: "A",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4,),
          OptionTile(
            goodAnswer: widget.questionModel.option1,
            description: widget.questionModel.option2,
            label: "B",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4,),
          OptionTile(
            goodAnswer: widget.questionModel.option1,
            description: widget.questionModel.option3,
            label: "C",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4,),
          OptionTile(
            goodAnswer: widget.questionModel.option1,
            description: widget.questionModel.option4,
            label: "D",
            optionSelected: optionSelected,
          ),
        ],
      ),
    );
  }
}
