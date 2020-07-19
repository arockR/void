import 'package:firebase_auth/firebase_auth.dart';
import 'package:mail/models/user/user.dart';

class Authentication{
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _gettingUser(FirebaseUser user){
    return user != null ? User(uid: user.uid , email: user.email) : null ;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_gettingUser);
  }

  // register with email

  Future registerWithEmail(String email, String password)async{

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _gettingUser(user); 
    }
    catch(error){
      print('login failed');
    }
  }

  //signin with email

  Future signinWithEmail(String email, String password)async{

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _gettingUser(user);
    }
    catch(error){
      print('login failed');
    }
  }
}