import 'package:flutter/material.dart';

Widget discreteHelperAppBar(BuildContext context){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 20),
      children: <TextSpan>[
        TextSpan(text: 'Discrete', style: TextStyle(fontWeight: FontWeight.w300) ),
        TextSpan(text: 'Helper', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}