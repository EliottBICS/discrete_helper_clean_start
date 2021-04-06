import 'package:discrete_helper_clean_start/widgets/BICSColors.dart';
import 'package:flutter/material.dart';

Widget discreteHelperAppBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 20),
      children: <TextSpan>[
        TextSpan(
            text: 'Discrete', style: TextStyle(fontWeight: FontWeight.w300)),
        TextSpan(text: 'Helper', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget bicsBlueButton(BuildContext context, String label) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: BICSGreen(), borderRadius: BorderRadius.circular(30)),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 20,
    child: Text(label, style: TextStyle(color: Colors.white)),
  );
}
