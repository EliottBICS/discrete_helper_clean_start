import 'package:discrete_helper_clean_start/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: discreteHelperAppBar(context),
        brightness: Brightness.dark,
        elevation: 1,
      ),
      body: Form(
        key : _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val) {
                  print("empty mail");
                  return val.isEmpty ? "The mail field is empty" : null;
                },
                decoration: InputDecoration(hintText: "email"),
                onChanged: (val) {
                  email = val;
                },
              ),
              TextFormField(
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
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 17) ,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                alignment: Alignment.center,
                child: Text("Sign In", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "Sign up",
                      style: TextStyle(fontSize: 15,
                        decoration: TextDecoration.underline,),
                  ),
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
