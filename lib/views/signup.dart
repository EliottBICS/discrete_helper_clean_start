import 'package:discrete_helper_clean_start/services/auth.dart';
import 'package:discrete_helper_clean_start/views/home.dart';
import 'package:discrete_helper_clean_start/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:discrete_helper_clean_start/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;
  signUp()  {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
        
      });

      authService.signUpWithEmailAndPassword(email, password).then((value) {
        if(value != null){
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()
          ));
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
      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
      ) : Form(
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
                  print("You clicked on Sign Up");
                  signUp();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                  ),
                  alignment: Alignment.center,
                  child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                ),
              ),
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
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
