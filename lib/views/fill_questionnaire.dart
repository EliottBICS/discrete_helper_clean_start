import 'package:flutter/material.dart';

class FillQuestionnaire extends StatefulWidget {

  final String questionnaireId;
  //constructor
  FillQuestionnaire(this.questionnaireId);



  @override
  _FillQuestionnaireState createState() => _FillQuestionnaireState();
}

class _FillQuestionnaireState extends State<FillQuestionnaire> {

  @override
  void initState() {
    print("This questionnaire's ID is ${widget.questionnaireId}");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
