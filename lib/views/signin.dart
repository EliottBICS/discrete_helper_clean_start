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
        child: Container(
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
                validator: (val) {
                  return val.isEmpty ? "The password field is empty" : null;
                },
                decoration: InputDecoration(hintText: "password"),
                onChanged: (val) {
                  password = val;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
