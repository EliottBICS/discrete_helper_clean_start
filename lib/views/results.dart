import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:discrete_helper_clean_start/preferences/functions.dart';
import 'signin.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  bool perfect;
  int score;
  Results({@required this.correct, @required this.incorrect, @required this.total, @required this.perfect});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    widget.score = 0;
    widget.perfect = false;
    if(widget.correct == widget.total){
      widget.perfect = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignIn()));
            preferenceFunctions.forgetUser();
          })
        ],
      ),
      body : Container(
        child: Center(
          child: Column(
              children:[
                SizedBox(height: 20,),
            Text("${widget.correct}/${widget.total}", style: TextStyle(fontSize: 50),),
          SizedBox(height: 50,),
          Text("Right answers : ${widget.correct} \nWrong answers : ${widget.incorrect}"),
          //If the score is perfect, let the student know
          Text(widget.perfect? "Perfect score!" : ""),

          ]),

        ),
      )
    );
  }
}
