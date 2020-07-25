import 'package:flutter/material.dart';
import 'package:mailee/auth/screens/signin.dart';
import 'package:mailee/auth/screens/signup.dart';

class AuthControll extends StatefulWidget {
  AuthControll({Key key}) : super(key: key);

  @override
  _AuthControllState createState() => _AuthControllState();
}

class _AuthControllState extends State<AuthControll> {
  bool showSignIn = true;

   void toggleView(){
    setState( () => showSignIn = !showSignIn );
  }

  @override
  Widget build(BuildContext context) {

     if(showSignIn){
       return SignInEmail(toggleView:toggleView);
    }else{
      return SignUp(toggleView:toggleView);
    }
  }
}