import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/models/mail/con_model.dart';
import 'package:mail/models/mail/mail_model.dart';
import 'package:mail/models/user/user.dart';
import 'package:mail/pages/view_mail.dart';
import 'package:provider/provider.dart';


  class MailUi extends StatefulWidget {
    @override
    _MailUiState createState() => _MailUiState();
  }
  
  class _MailUiState extends State<MailUi> {

    List mailinfo = [];
    var id ;
    var email;
    var body;

    void onpressToImportant() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Marked as important"),
      backgroundColor: Colors.blueAccent,
       action: SnackBarAction(
          label: 'UNDO',onPressed: (){},)
    ),
    );
  }

     void onpressToBin() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Moved to bin"),
      backgroundColor: Colors.blueAccent,
       action: SnackBarAction(
          label: 'UNDO',onPressed: (){},)
    ),
    );
  }

     void onpressDelete() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Deleted"),
      backgroundColor: Colors.blueAccent,
       action: SnackBarAction(
          label: 'UNDO',onPressed: (){},)
    ),
    );
  }

   Widget  create(){
    return AlertDialog(
                    content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                    InkWell(
                      onTap: (){
                        //MailService().saveToImportant(mailinfo.n, image, mail, caption, body)
                        Navigator.pop(context);
                        onpressToImportant();
                      },
                        child: Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.bottomLeft,
                        child: Text('select',style: TextStyle(fontSize: 18.0),),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                         Navigator.pop(context);
                        onpressToBin();
                      },
                        child: Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.bottomLeft,
                        child: Text('mark as important',style: TextStyle(fontSize: 18.0),),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                         Navigator.pop(context);
                        onpressDelete();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.bottomLeft,
                        child: Text('move to bin',style: TextStyle(fontSize: 18.0),),
                      ),
                    ),
                    SizedBox(height:2.0),
                    ],
                    ),
                    );
          }
      showWarning()async{
      return showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){

          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('This action cannot be reversed'),
            actions: <Widget>[
              FlatButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: Text('No')
              ),
              FlatButton(onPressed: ()async{

              Firestore.instance.collection('User').document(email)
                            .collection('mails').document('1').collection('inbox').where(
                              'body', isEqualTo:  body).getDocuments().then((value){
                                value.documents.first.reference.delete();
                              });
              Navigator.pop(context);
              onpressDelete(); 
              Navigator.pop(context);
              
              }, 
              child: Text('Yes')
              )
            ]
            );
            });
            }

    @override
    Widget build(BuildContext context) {
      
      final icon = Icons.more_vert;
      final black = Colors.black26;
      final white = Colors.white;
      final text = 'true';
      final mail = Provider.of<List<GetMails>>(context);
      final user = Provider.of<User>(context);
      
      return ListView.builder(
        itemCount: mail.length,
        itemBuilder: (context , index){
          print(mail[index].id);
          return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewMail(name:mail[index].name, caption: mail[index].caption , body:mail[index].body, id:mail[index].id, timestamp:mail[index].timestamp, isRead:mail[index].isRead)));
            },

            child: Container(
              color: mail[index].isRead.toString() != text ?  white : black,
              child: ListTile(
              leading: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text( mail[index].name , overflow: TextOverflow.ellipsis,softWrap: false, style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                  SizedBox(width:10.0),
                  Text(mail[index].caption , overflow: TextOverflow.ellipsis,softWrap: false,style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
                ],
              ),
              subtitle: Text(
                mail[index].body,
                overflow: TextOverflow.ellipsis,softWrap: false,
                style: TextStyle(
                  fontSize: 15.0
                ),
              ),
            trailing: Container(child: InkWell(child: Icon(icon,size: 20.0,),
            onTap:(){
              return  showDialog(context: context , builder: (BuildContext context){
              return AlertDialog(
                content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                      InkWell(
                        onTap: ()async{
                          final id = mail[index].id;
                          final body = mail[index].body;
                          await MailService(docid:id,email: user.email).moveToBin(mail[index].name, mail[index].image, mail[index].mail, mail[index].caption, mail[index].body);
                          Firestore.instance.collection('User').document(user.email)
                                       .collection('mails').document('1').collection('inbox').where(
                                         'body', isEqualTo:  body).getDocuments().then((value){
                                           value.documents.first.reference.delete();
                                         });
                          Navigator.pop(context);
                          onpressToBin();
                        },
                          child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text('move to bin',style: TextStyle(fontSize: 18.0),),
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          final id = mail[index].id;
                          await MailService(docid:id,email: user.email).saveToImportant(mail[index].name, mail[index].image, mail[index].mail, mail[index].caption, mail[index].body);
                          Navigator.pop(context);
                          onpressToImportant();
                        },
                          child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text('mark as important',style: TextStyle(fontSize: 18.0),),
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          setState(() {
                            body = mail[index].body;
                            id = mail[index].id;
                            email = user.email;
                          });
                         showWarning();
                         // Navigator.pop(context);
                        },

                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text('delete',style: TextStyle(fontSize: 18.0,color: Colors.red),),
                        ),
                      ),
                      SizedBox(height:2.0),
                      ],
                      ),
              );});

            } ,)),
          ),
            ),);
          }
        );
  }  
}
  