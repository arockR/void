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
      appBar: AppBar(),
      body: ListView(
      children: <Widget>[

        SizedBox(height: 10.0,),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'E-Mail',
              labelStyle: TextStyle(fontSize: 19.0,color: Colors.black,fontWeight: FontWeight.w500)
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
          child: TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 19.0,color: Colors.black,fontWeight: FontWeight.w500)
            ),
          ),
        ),

        Center(
          child: FlatButton(
            color: Colors.blue,
            onPressed: ()async{
              dynamic result = await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
            }, 
            child: Text('sign up')
            ),
        ),

        InkWell(
          onTap: (){
            widget.toggleView();
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
          },
            child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 20.0,top: 20.0),
            child: Text('Have a account ? Login', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          ),
        )
      ]
    ),
    );
  }
}
