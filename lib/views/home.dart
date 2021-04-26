import 'package:discrete_helper_clean_start/preferences/functions.dart';
import 'package:discrete_helper_clean_start/services/database.dart';
import 'package:discrete_helper_clean_start/views/create_questionnaire.dart';
import 'package:discrete_helper_clean_start/views/fill_questionnaire.dart';
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
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                          questionnaireId: ds["questionnaireId"],
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
    databaseService.fetchQuestionnaires().then((val) {
      setState(() {
        questionnaireStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: BICSBlueAccent(), //For testing purposes
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
  final String questionnaireId;

  //constructor
  Questionnaire({this.imgUrl, this.description, this.title, this.questionnaireId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FillQuestionnaire(
          questionnaireId
        )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        //padding: EdgeInsets.symmetric(vertical: 10),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 20,
                fit: BoxFit.fitWidth,
              ),
              //the width is now dependant on the width of the screen used
              //the image must ensure that its whole width is conserved, regardless of its heigth
              borderRadius: BorderRadius.circular(15),
              //I make the edges of the rectangles round, with a radius of 15
            ),
            Container(
              
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                      child: Text(
                    title,
                    style: TextStyle(color: BICSWhite(), fontWeight: FontWeight.bold, fontSize: 20),
                  )),
                  FittedBox(child: Text(description, style: TextStyle(color: BICSWhite())),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
