import 'package:discrete_helper_clean_start/widgets/BICSColors.dart';
import 'package:flutter/material.dart';

class SuggestionTile extends StatefulWidget {
  final String label, description, goodAnswer, optionSelected;

  SuggestionTile({@required this.description, @required this.label, @required this.goodAnswer, @required this.optionSelected});


  @override
  _SuggestionTileState createState() => _SuggestionTileState();
}

class _SuggestionTileState extends State<SuggestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //Prevents from touching the border of the screen
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.optionSelected == widget.description ? //If an answer is picked, change color
                widget.optionSelected == widget.goodAnswer ? BICSGreen().withOpacity(0.7) //If the answer picked is the good one, turn to green
                : BICSRed().withOpacity(0.7) //If it's wrong, it turns to red
                : Colors.grey //If no answer is picked, stay grey
              ),
              borderRadius: BorderRadius.circular(30)

            ),
            alignment: Alignment.center,
            child: Text(widget.label,
              style: TextStyle(
              color: widget.optionSelected == widget.description?
                  widget.optionSelected == widget.goodAnswer ?
                  Colors.green :
                  Colors.red
                : Colors.grey
            ),
            ),
          ),
          SizedBox(width: 8,),

          Text(widget.description, style: TextStyle(fontSize: 17, color: Colors.black),)
        ],
      ),
    );

  }
}
