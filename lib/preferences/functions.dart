import 'package:shared_preferences/shared_preferences.dart';

class preferenceFunctions{

  static String UserLoggedInID = "UserLoggedInID";

  rememberUser({bool isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserLoggedInID, isLoggedin);
  }
}