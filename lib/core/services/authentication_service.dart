import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({ @required String email, @required String password }) async{
    try{
      var user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return user != null;
    }catch(e){
      return e.message;
    }
  }

  Future signUpWithEmail({ @required String email, @required String password }) async{
    try{
      var result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user != null;
    }catch(e){
      return e.message;
    }
  }
  // Gets the current user
  Future<bool> isUserLoggedIn() async{
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}