import 'package:shared_preferences/shared_preferences.dart';

class preferenceFunctions{

  static String UserLoggedInID = "UserLoggedInID";

  //Function used to save the ID of the current user in order to remember it
  static rememberUser({bool isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserLoggedInID, isLoggedin);
  }

  //Function used to know if a user is logged in or not
  static Future<bool> getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(UserLoggedInID);
  }

}