import 'package:flutter/material.dart';
import 'package:mailee/auth/user.dart';
import 'package:mailee/models/mail/mail.dart';
import 'package:mailee/models/mail/mail_model.dart';
import 'package:mailee/pages/groups.dart';
import 'package:mailee/pages/mail/bin.dart';
import 'package:mailee/pages/mail/create_mail.dart';
import 'package:mailee/pages/mail/important.dart';
import 'package:mailee/pages/mail/mail_home.dart';
import 'package:mailee/pages/mail/sent.dart';
import 'package:mailee/pages/settings.dart';
import 'package:mailee/pages/vault.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentindex = 0;
  final List<Widget> _pageroutes = [
    HomeContent(),
    Groups(),
    CloudVault(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {

    //final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('VOID',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 23.0),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          color: Colors.black,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => (CreateMail())));
          })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black26,
        currentIndex: _currentindex,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home'),backgroundColor: Colors.blueAccent ),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline),title: Text('Groups')),
        BottomNavigationBarItem(icon: Icon(Icons.cloud_upload),title: Text('Vault')),
        BottomNavigationBarItem(icon: Icon(Icons.settings),title: Text('settings')),
      ],
      onTap:(index){
        setState(() {
          _currentindex = index;
        });
      } ,
      ),
      body: _pageroutes[_currentindex]
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

    return StreamProvider<List<GetMails>>.value(
      value: MailService(email: user.email).mail,
      child: Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[

              SizedBox(height: 10,),
              Container( 
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(color: Colors.blueAccent[100],borderRadius:BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text('Sent',style: TextStyle(fontSize:17.0,fontWeight:FontWeight.w400),),
                  trailing: Icon(Icons.navigate_next),
                  onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => (SentMails())));
                  },
                ),
              ),
              SizedBox(height: 10,),

              Container( 
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(color: Colors.blueAccent[100],borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text('Important',style: TextStyle(fontSize:17.0,fontWeight: FontWeight.w400),),
                  trailing: Icon(Icons.navigate_next),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => (ImportantMails())));
                  },
                ),
              ),
              SizedBox(height: 10,),

              Container( 
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(color: Colors.blueAccent[100],borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text('Bin',style: TextStyle(fontSize:17.0,fontWeight: FontWeight.w400),),
                  trailing: Icon(Icons.navigate_next),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => (Bin())));
                  },
                ),
              ),

              SizedBox(height: 10,),

              Container(
                padding: EdgeInsets.only(left:10.0,top: 20.0,bottom: 25.0),
                child: Text('Inbox',style: TextStyle(fontSize:22.0,fontWeight: FontWeight.w500),),
              ),

              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                ),
            child:Container(child:MailUi())
            )

            ]),
        ),
          
      ]),
    );
  }
}


