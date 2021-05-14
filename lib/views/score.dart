import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_helper_clean_start/models/student.dart';
import 'package:discrete_helper_clean_start/services/auth.dart';
import 'package:discrete_helper_clean_start/services/database.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  final String uid;

  //constructor
  ScoreScreen(this.uid);//uid gets communicated by last screen (I might change that)


  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance; //get user id
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot userSnapshot;

  StudentModel getStudentModelFromSnapShot(DocumentSnapshot userSnapshot){

  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
        elevation: 1,
      ),
      body: Container(
        child: Column(),
      ),
    );
  }
}
