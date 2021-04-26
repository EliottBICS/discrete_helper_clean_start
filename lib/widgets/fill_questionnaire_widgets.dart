import 'package:discrete_helper_clean_start/widgets/BICSColors.dart';
import 'package:flutter/material.dart';

class PotentialAnswer extends StatefulWidget {
  final String label, description, goodAnswer, optionSelected;

  PotentialAnswer({@required this.description, @required this.label, @required this.goodAnswer, @required this.optionSelected});


  @override
  _PotentialAnswerState createState() => _PotentialAnswerState();
}

class _PotentialAnswerState extends State<PotentialAnswer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.description == widget.optionSelected ? //If an answer is picked, change color
                widget.optionSelected == widget.goodAnswer ? BICSGreen().withOpacity(0.7) //If the answer picked is the good one, turn to green
                : BICSRed().withOpacity(0.7) //If it's wrong, it turns to red
                : BICSGrey().withOpacity(0.7) //If no answer is picked, stay grey
              )

            ),
            child: Text("${widget.label}", style: TextStyle(
              color: widget.optionSelected == widget.description ? widget.optionSelected == widget.goodAnswer ?
                  BICSGreen().withOpacity(0.7) //Right answer makes the text green
              : BICSRed().withOpacity(0.7) //Wrong answer makes it red
              : BICSGrey().withOpacity(0.7) //No answer makes it grey
            ),),
          ),
          SizedBox(width: 8,),

          Text(widget.description, style: TextStyle(fontSize: 17, color: Colors.black),)
        ],
      ),
    );

  }
}
