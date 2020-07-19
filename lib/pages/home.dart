import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mail/models/mail/con_model.dart';
import 'package:mail/models/mail/mail_model.dart';
import 'package:mail/models/user/user.dart';
import 'package:mail/pages/bin.dart';
import 'package:mail/pages/create_mail.dart';
import 'package:mail/pages/important_mails.dart';
import 'package:mail/pages/inbox.dart';
import 'package:mail/pages/saved_mails.dart';
import 'package:mail/pages/settings.dart';
import 'package:mail/ui_screens/mail_home.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

   getUser(user)async{
      FirebaseAuth _auth = FirebaseAuth.instance;
      final user =await _auth.currentUser();
      final username = user.displayName;
   }
    

    return Scaffold(
      appBar: AppBar(
        title: Text('mailee'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.add),
          iconSize: 30,
          color: Colors.black54,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => (CreateMail())));
          }
          ),
        ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[

              Container(
                padding: EdgeInsets.only(top:30.0),
                height: 150.0,
                color: Colors.blueAccent,
                child: ListTile(
                  leading: Container(
                    width: 55.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(70.0), color: Colors.white,),
                  ),
                  title: Text( '' ,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
                ),
              ),

              ListTile(
                title: Text('Inbox', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                onTap: (){
                   Navigator.pop(context);
                   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Inbox(title:'inbox')));
                },
              ),

              ListTile(
                title: Text('Saved', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (SavedMails())));
                },
              ),

              ListTile(
                title: Text('Important', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (ImportantMails())));
                },
              ),

              ListTile(
                title: Text('bin', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (Bin())));
                },
              ),
              ListTile(
                title: Text('settings', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                //trailing: Icon(Icons.cloud,color: Colors.blueAccent,size: 20.0,),
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => (Settings())));},
              ),
               InkWell(
                 onTap: (){
                  // _logOut();
                 },
                  child: ListTile(
                  title: Text('logout', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
              ),
               ),


            ],
            ),
        ),
      //backgroundColor: Colors.blue,
      body :HomeContent()
    );
  }
}


class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //FirebaseUser user = await _auth.currentUser();
    return StreamProvider<List<GetMails>>.value(
      value: MailService(email: user.email).mail,
      child:  MailUi(),
      
      );
  }
}
