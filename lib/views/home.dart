import 'package:discrete_helper_clean_start/preferences/functions.dart';
import 'package:discrete_helper_clean_start/services/database.dart';
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
//You can go to add_questionnaire from here

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
  Stream questionnaireStream;
  DatabaseService databaseService = new DatabaseService();

  Widget questionnairesColumn() {
    //A list of available questionnaires in the form of a column

    return Container(
      child: Column(
        children: [
          StreamBuilder(
              stream: questionnaireStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        return Questionnaire(
                          imgUrl: //"https://bicshub.uni.lu/static/images/main-slider/slide-bics.png",
                              // snapshot.data.docs[index].data["imgURL"],
                              ds["imgURL"],

                          title: ds["questionnaireTitle"],

                          description: ds["questionnaireDescription"],
                          // snapshot.data.docs[index].data["questionnaireDescription"],
                        );
                      });
                }
              })
        ],
      ),
    );
  }

  @override
  void initState() {
    //initial state of the app
    //we want to fetch the questionnaires on the database as soon as this screen
    //is reached
    databaseService.fetchQuestionnairedata().then((val) {
      setState(() {
        questionnaireStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
      ),
      body: Column(children: [
        Container(child: questionnairesColumn()),
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              // Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                    preferenceFunctions.forgetUser();
                  },
                  child: Center(child: bicsRedButton(context, "sign out"))),
              SizedBox(height: 10)
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //We use push to be able to go back, as opposed to pushreplacement
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateQuestion()));
        },
      ),
    );
  }
}

class Questionnaire extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  Questionnaire({this.imgUrl, this.description, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: [
          Image.network(imgUrl),
          Container(
            child: Column(
              children: [Text(title), Text(description)],
            ),
          )
        ],
      ),
    );
  }
}
