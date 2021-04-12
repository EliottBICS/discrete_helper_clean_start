import 'package:discrete_helper_clean_start/preferences/functions.dart';
import 'package:discrete_helper_clean_start/views/home.dart';
import 'package:discrete_helper_clean_start/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  bool _isLoggedIn =false;
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  //If the user is already logged in, it will return true
  checkUserLoggedIn() async {
    preferenceFunctions.getUser().then((value){
      setState(() {
        _isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Discrete maths application",
      home:  (_isLoggedIn ?? false) ? Home() : SignIn(),
      //if _isLoggedIn is null, make it false
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}
