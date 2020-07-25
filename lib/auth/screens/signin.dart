import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInEmail extends StatefulWidget {
  SignInEmail({this.toggleView});

  final Function toggleView;

  @override
  _SignInEmailState createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: ListView(
          children: <Widget>[

            SizedBox(height: 200.0,),

            Container(
              alignment: Alignment.center,
              child: Text('VOID',style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,color:Colors.indigoAccent),),
            ),
            SizedBox(height: 20.0,),
            Container(
              alignment: Alignment.center,
              child: Text('Please log in to continue',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color:Colors.indigo),),
            ),
              SizedBox(height: 20.0,),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),
              height: 50.0,
              width: 20.0,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54),borderRadius: BorderRadius.circular(7.0)),
                  labelText: 'E-Mail',
                  labelStyle: TextStyle(fontSize: 16.0,color: Colors.black54,fontWeight: FontWeight.w500)
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),
              height: 50.0,
              width: 20.0,
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54),borderRadius: BorderRadius.circular(7.0)),
                  labelText: 'Password',
                  labelStyle: TextStyle( fontSize: 16.0,color: Colors.black54,fontWeight: FontWeight.w500)
                ),
              ),
            ),

            Center(
              child: FlatButton(
                color: Colors.blue[300],
                onPressed: ()async{
                await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                }, 
                child: Text('login',style: TextStyle(fontSize: 20.0)),
                ),
            ),

            InkWell(
              onTap: (){widget.toggleView();},
                child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(right: 20.0,top: 30.0),
                child: Text('New user ? Register here..', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
              ),
            )
          ]
      ),
        ),
    );
  }
}