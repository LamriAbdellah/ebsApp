import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //make firebaseuser to our user
  User _userfromfirebase (FirebaseUser user){
    return user != null ? User(user.uid) : null;
  }
  // detecter la connection
  Stream<User> get user{
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userfromfirebase(user));
        .map(_userfromfirebase);
  }


  Future ResetPassword(String email)async{
    try {
      String message="email sent succefully";
      await _auth.sendPasswordResetEmail (email: email)
          .then((value){
        message="email sent succefully";
      });
      return message;
    }
    catch(error){
      String errorMessage = "their are an error";
      return errorMessage ;
    }

  }
//connecter avc email password

  Future singIn (String email,String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromfirebase(user);

    }
    catch (error) {
      String errorMessage = "";

      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }
//insciption
  Future register ( String email,String password,String pseudo,int algo,
      int analyse,
      int algebre,
      int elect,
      int mecanq,
      int poo,
      String imageUrl) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseServices(uid: user.uid).updateUserData(pseudo,email,algo,
          analyse,
          algebre,
          elect,
          mecanq,
          poo,
          imageUrl);
      return _userfromfirebase(user);

    }

    catch (error) {
      String errorMessage ="";

      switch (error.code) {
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Your password is too weak";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email is invalid";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Email is already in use on different account";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Your email is invalid";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }

  }

// get current user

//deconnecter
  Future SingOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e){
      return null;
    }
  }



}