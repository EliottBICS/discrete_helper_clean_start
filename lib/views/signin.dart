import 'package:discrete_helper_clean_start/preferences/functions.dart';
import 'package:discrete_helper_clean_start/services/auth.dart';
import 'package:discrete_helper_clean_start/views/home.dart';
import 'package:discrete_helper_clean_start/views/signup.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:discrete_helper_clean_start/widgets/BICSColors.dart';
import 'package:discrete_helper_clean_start/models/student.dart';
import 'package:discrete_helper_clean_start/preferences/functions.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth auth = FirebaseAuth.instance; //get user id
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      final User user = auth.currentUser; //This is the user
      final uid = user.uid; //This is the user's key
      print("The key is ${uid}");
      print("The user is ${user}");
      await authService.signInEmailPassword(email, password).then((val) {
        if (val != null) {
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
              child: Center(child: CircularProgressIndicator()),
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
                          signIn();
                          print("You clicked on sign in");
                        },
                        child: bicsBlueButton(context, "Sign In")),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Sign up",
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
