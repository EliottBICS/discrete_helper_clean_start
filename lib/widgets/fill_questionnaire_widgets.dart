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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.optionSelected == widget.description ? //If an answer is picked, change color
                widget.description == widget.goodAnswer ? Colors.green.withOpacity(0.7) //If the answer picked is the good one, turn to green
                : Colors.red.withOpacity(0.7) //If it's wrong, it turns to red
                : Colors.grey.withOpacity(0.7) //If no answer is picked, stay grey
              )

            ),
            child: Text(widget.label,
              style: TextStyle(
              color: widget.optionSelected == widget.description?
                  Colors.green :
                  Colors.red,
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
