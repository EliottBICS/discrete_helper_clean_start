import 'package:discrete_helper_clean_start/widgets/BICSColors.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        brightness: Brightness.dark
      ),
      floatingActionButton: InkWell(
        splashColor: BICSBlue(),
        onLongPress: (){
          setState(() {
            score = 0;
          });
        },
        child: FloatingActionButton(
          onPressed: (){
            // FirebaseFirestore.instance.collection('data').add({'not text': 'data added through app'});
            setState(() {
              score = score +1;
            });
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('$score')
            ],
          )
        ],
      ),
    );
  }
}
