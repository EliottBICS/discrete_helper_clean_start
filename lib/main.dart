import 'package:discrete_helper_clean_start/views/signin.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Discrete maths application",
      home: SignIn(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}
