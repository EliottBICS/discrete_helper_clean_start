import 'package:discrete_helper_clean_start/preferences/functions.dart';
import 'package:discrete_helper_clean_start/views/create_question.dart';
import 'package:discrete_helper_clean_start/views/signin.dart';
import 'package:discrete_helper_clean_start/widgets/BICSColors.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:discrete_helper_clean_start/main.dart';

//The homescreen. Users that are properly identified end up here
//You can access questionnaires from here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore db = FirebaseFirestore.instance;
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            // Spacer(),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SignIn()));
              print("I still need to implement this functionality, right now it only brings the user back to the login screen \n I would like it to also set its _isLoggedIn to false");
              preferenceFunctions.forgetUser();
              },
              child: Center(child: bicsRedButton(context, "sign out"))),
          SizedBox(height: 10)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //We use push to be able to go back, as opposed to pushreplacement
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => CreateQuestion()
              ));
        },
      ),
    );
  }
}
