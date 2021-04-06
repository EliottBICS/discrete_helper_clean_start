import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:discrete_helper_clean_start/models/student.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Student _userFromFirebaseUser(User user) {
    return user != null ? Student(uid: user.uid) : null;
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      print("I'm trying to sign up");
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = authResult.user;
      print("I signed up");
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print("did not work");
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
