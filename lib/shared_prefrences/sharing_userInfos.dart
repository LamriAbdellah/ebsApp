import 'package:epsapp/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class sharingUserInfo{
  static String sharedprefrencesLogedInkey="ISLOGGEDIN";
  static String sharedprefrencesUserNameInkey="USERNAME";
  static String sharedprefrencesUserEmailInkey="USEREMAIL";
  static String sharedprefrencesUserSTATEInkey="USERSTATE";
  static Future<bool> saveuserLoggedInSharedprefences (bool isUserLoggedIn) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return await prefs.setBool(sharedprefrencesLogedInkey, isUserLoggedIn);
   }
  static Future<bool> saveuserStateSharedprefences (String isUserNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrencesUserSTATEInkey, isUserNew);
  }

  static Future<bool> saveuserUserNameSharedprefences (String UserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrencesUserNameInkey,UserName);
  }
  static Future<bool> saveuserUserEmailSharedprefences (String UserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrencesUserEmailInkey,UserEmail);
  }
  //get user infos
 static Future<bool> getuserLoggedInSharedprefences () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedprefrencesLogedInkey);
  }
  static Future<String> getuserStateSharedprefences () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedprefrencesUserSTATEInkey);
  }
 static Future<String> getuserNameSharedprefences () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedprefrencesUserNameInkey);

  }
 static Future<String> getuserEmailSharedprefences () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedprefrencesUserEmailInkey);

  }

}