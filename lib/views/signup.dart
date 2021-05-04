import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_helper_clean_start/services/auth.dart';
import 'package:discrete_helper_clean_start/services/database.dart';
import 'package:discrete_helper_clean_start/views/home.dart';
import 'package:discrete_helper_clean_start/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:discrete_helper_clean_start/preferences/functions.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String name, email, password, userID;
  AuthService authService = new AuthService();
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();




  //I can modify signup to add the user to the database
  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      authService.signUpWithEmailAndPassword(email, password).then((value) async {
        final User user = auth.currentUser; //obtains the current user
        final uid = user.uid; //extract its id
        if (value != null) {
          Map<String, dynamic> userData = {
            "userID" : uid,
            "name" : name,
            "FillerScore" : 0,
            "MakerScore" : 0,
          };
          await databaseService.addUser(userData, uid);




          setState(() {
            _isLoading = false;
          });
          preferenceFunctions.rememberUser(isLoggedin: true);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
        elevation: 1,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "The name field is empty" : null;
                      },
                      decoration: InputDecoration(hintText: "name"),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "The mail field is empty" : null;
                      },
                      decoration: InputDecoration(hintText: "email"),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "The password field is empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(hintText: "password"),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: bicsBlueButton(context, "Sign up")),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
