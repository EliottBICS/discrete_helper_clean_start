import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_helper_clean_start/models/student.dart';
import 'package:discrete_helper_clean_start/services/auth.dart';
import 'package:discrete_helper_clean_start/services/database.dart';
import 'package:discrete_helper_clean_start/views/signin.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:discrete_helper_clean_start/preferences/functions.dart';

class ScoreScreen extends StatefulWidget {

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}


int totalScore = 0;
int fillerScore = 0;
int makerScore = 0;
String name = "";
String uid = "";

class _ScoreScreenState extends State<ScoreScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance; //get user id
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  StudentModel studentModel;
  QuerySnapshot usersSnapshot;


  StudentModel getStudentModelFromSnapShot(DocumentSnapshot userSnapshot){




    StudentModel studentModel = new StudentModel();

    if(userSnapshot != null ){ //check if the snapshot exists
      print("Snapshot exists");
      print(userSnapshot);
    }else{
      print("No snapshot!");
    }
    // User user = auth.currentUser; //obtains the current user
    // studentModel.uid = user.uid;
    studentModel.uid = uid;


    studentModel.fillerScore = userSnapshot.data()["FillerScore"];
    studentModel.makerScore = userSnapshot.data()["MakerScore"];
    studentModel.name = userSnapshot.data()["name"];

    print("FillerScore: ${studentModel.fillerScore}");
    print("MakerScore: ${studentModel.makerScore}");
    print("Name : ${studentModel.name}");
    print("ID : ${studentModel.uid}");



    return studentModel;


  }





  @override
  void initState() { //check if the user id is properly recognized
    User user = auth.currentUser; //obtains the current user
    uid = user.uid; //extract its id
    print("This user's ID is ${uid}");

    databaseService.getUserData(uid).then((value){
      usersSnapshot = value;
      print("UsersSnapshot correctly imported");
      studentModel = getStudentModelFromSnapShot(usersSnapshot.docs[0]);

      setState(() {
        fillerScore = studentModel.fillerScore;
        makerScore = studentModel.makerScore;
        totalScore = fillerScore + makerScore;
      });


      // int total = usersSnapshot.docs.length;
      //
      //
      //
      // // studentModel = getStudentModelFromSnapShot(usersSnapshot.docs[0]);
      // print("Total of scores for this user (should be one) : ${total}");



      print("This is zero ${studentModel.fillerScore}");
    });



    // final studentModel = getStudentModelFromSnapShot(usersSnapshot.docs[0],);

    setState(() {

    });

    print("Total score is ${totalScore}");



    super.initState();

  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
        elevation: 1,
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignIn()));
            preferenceFunctions.forgetUser();
            
          })
        ],
      ),


      body: Container(
      child: Column(children: [
        Text("Total Score : ${totalScore}"),
        Text("Maker Score : ${fillerScore}"),
        Text("Filler Score : ${makerScore}"),




      ], ),
        // child: Column(
        //   children: [
        //
        //     usersSnapshot.docs == null?
        //         //If we're still loading the snapshot
        //     Container(
        //       child: Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //     )
        //     //Else, if the snapshot is loaded
        //          : Row(
        //       children: [
        //         ScoreDisplay(
        //             studentModel : getStudentModelFromSnapShot(usersSnapshot.docs[0]))
        //       ],
        //     ),
        //     Row(),
        //     Row(),
        //
        //   ],
        // ),
      ),
    );
  }
}

class ScoreDisplay extends StatefulWidget {
  final StudentModel studentModel;

  ScoreDisplay({@required this.studentModel});

  @override
  _ScoreDisplayState createState() => _ScoreDisplayState();
}

class _ScoreDisplayState extends State<ScoreDisplay> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Score : ${widget.studentModel.fillerScore}")
        ],
      ),
    );
  }
}
