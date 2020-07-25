import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({this.toggleView});

  final Function toggleView;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
      children: <Widget>[

         SizedBox(height: 200.0,),

            Container(
              alignment: Alignment.center,
              child: Text('VOID',style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,color:Colors.indigoAccent),),
            ),
            SizedBox(height: 20.0,),
            Container(
              alignment: Alignment.center,
              child: Text('Create your account',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color:Colors.indigo),),
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

            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),
              height: 50.0,
              width: 20.0,
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54),borderRadius: BorderRadius.circular(7.0)),
                  labelText: 'Re-type password',
                  labelStyle: TextStyle( fontSize: 16.0,color: Colors.black54,fontWeight: FontWeight.w500)
                ),
              ),
            ),

        Center(
          child: FlatButton(
            color: Colors.blue[300],
            onPressed: ()async{
              await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
            }, 
              child: Text('Register',style: TextStyle(fontSize: 20.0)),
            ),
        ),

        InkWell(
          onTap: (){
            widget.toggleView();
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
          },
            child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 20.0,top: 30.0),
            child: Text('Already have a account ? Login', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          ),
        )
      ]
    ),
    );
  }
}
