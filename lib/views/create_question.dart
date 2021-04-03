import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CreateQuestion extends StatefulWidget {
  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {

  final _formKey = GlobalKey<FormState>();
  String  questionnaireTitle, questionnaireDescription, imgURL;

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
