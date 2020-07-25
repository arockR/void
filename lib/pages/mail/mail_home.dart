import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailee/auth/user.dart';
import 'package:mailee/models/mail/mail.dart';
import 'package:mailee/models/mail/mail_model.dart';
import 'package:mailee/pages/mail/view_mail.dart';
import 'package:provider/provider.dart';

class MailUi extends StatefulWidget {
  @override
  _MailUiState createState() => _MailUiState();
}

class _MailUiState extends State<MailUi> {
  @override
  Widget build(BuildContext context) {

    final mail = Provider.of<List<GetMails>>(context);
    final user = Provider.of<User>(context);
    double width = MediaQuery. of(context). size. width;
    double neededwidth = width - 170.0;
    var id ;
    var email;
    var body;

    //snackbar

    void onpressToImportant() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Marked as important"),
      backgroundColor: Colors.blueAccent,
    ),
    );
  }

     void onpressToBin() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
    content: Text("Moved to bin"),
      backgroundColor: Colors.blueAccent,
    ),
    );
  }

     void onpressDelete() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Deleted"),
      backgroundColor: Colors.blueAccent,
    ),
    );
  }

    // show alert before delete

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

  return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: mail.length,
        itemBuilder: (context , index){ //print(mail[index].mail);
        return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                    ViewMail(name:mail[index].name,image: mail[index].image, mail:mail[index].mail, caption: mail[index].caption , body:mail[index].body, id:mail[index].id, timestamp:mail[index].timestamp, isRead:mail[index].isRead,attachments:mail[index].attachments)));
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                    ClipOval(
                    child: Image.asset(
                    "assets/profile.png",
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                    Row(
                        children: <Widget>[
                          SizedBox(width: 50.0, child: Text( mail[index].name ?? 'name' ,maxLines: 1, overflow: TextOverflow.fade,softWrap: false, style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),)),
                          SizedBox(width:10.0),
                          SizedBox(width: neededwidth, child: Text( mail[index].caption ?? 'caption',maxLines: 1,  overflow: TextOverflow.fade,softWrap: false,style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),)),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      SizedBox(width: neededwidth, child: Text(mail[index].body ?? 'body',maxLines: 1, overflow: TextOverflow.fade,softWrap: false,style: TextStyle(fontSize: 15.0),)),
                      SizedBox(height: 20.0,),
                    ],
                    ),
                    ]
                  ),
                  IconButton(icon: Icon(Icons.more_vert,size: 25.0,), onPressed: (){


                      // MAIL ACTIONS

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
                                    await MailService(docid:id,email: user.email).moveToBin(mail[index].name, mail[index].image, mail[index].mail, mail[index].caption, mail[index].body,mail[index].timestamp);
                                    Firestore.instance.collection('User').document(user.email).collection('mails').document('1')
                                      .collection('inbox').where('body', isEqualTo:  body).getDocuments()
                                      .then((value){value.documents.first.reference.delete();});
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
                                      await MailService(docid:id,email: user.email).saveToImportant(id, mail[index].name, mail[index].image, mail[index].mail, mail[index].caption, mail[index].body,mail[index].timestamp, mail[index].attachments);
                                      onpressToImportant();
                                      Navigator.pop(context);
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
                                  ]
                            ));
                       });

                  })
          ],
        ),
      );
    }
  );
 }
}

