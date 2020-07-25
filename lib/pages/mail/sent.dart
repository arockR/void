import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailee/auth/user.dart';
import 'package:mailee/models/mail/mail.dart';
import 'package:mailee/models/mail/mail_model.dart';
import 'package:mailee/pages/mail/view_mail.dart';
import 'package:provider/provider.dart';

class SentMails extends StatefulWidget {
  @override
  _SentMailsState createState() => _SentMailsState();
}

class _SentMailsState extends State<SentMails> {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    return StreamProvider<List<GetMails>>.value(
      value: MailService(email: user.email).sentMails,
      child: Scaffold(
        appBar: AppBar(),
        body: SentMailUi(),
      )
    );
  }
}


class SentMailUi extends StatefulWidget {
  @override
  _SentMailUiState createState() => _SentMailUiState();
}

class _SentMailUiState extends State<SentMailUi> {
  @override
  Widget build(BuildContext context) {

    var body;
    var id;
    var email;
    final maillist = Provider.of<List<GetMails>>(context);
    final user = Provider.of<User>(context);
    double width = MediaQuery. of(context). size. width;
    double neededwidth = width - 130.0;

    // snackbar 

void onpressDelete() {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Deleted"), backgroundColor: Colors.blueAccent,),);
}

    // show warning

showWarning()async{
  return showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){

    return AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('This action cannot be reversed'),
        actions: <Widget>[
          FlatButton(onPressed: (){ Navigator.pop(context);}, child: Text('No')),

          FlatButton(onPressed: ()async{
          MailService(body: body,email: user.email).deletesavedDoc();
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
      itemCount: maillist.length,
      itemBuilder: (context , index){

        return ListTile(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewMail(image:maillist[index].image, name:maillist[index].name, caption: maillist[index].caption , body:maillist[index].body, id:maillist[index].id, timestamp:maillist[index].timestamp, isRead:maillist[index].isRead)));
          },
          onLongPress: (){
            return  showDialog(context: context , builder: (BuildContext context){
                  return AlertDialog(
                    content: InkWell(
                      onTap: ()async{
                        setState(() {
                            body = maillist[index].body;
                            id = maillist[index].id;
                            email = user.email;
                          });
                      },
                      child: InkWell(
                        onTap: (){showWarning();},
                        child: Container(padding: EdgeInsets.all(10.0), child: Text('Delete',style: TextStyle(fontSize: 18.0),))
                        ),
                      ),
                    );
                });
            },

          leading: Icon(Icons.done_all,color: Colors.blueGrey,),
          title:SizedBox(width: neededwidth, child: Text(maillist[index].caption , overflow: TextOverflow.ellipsis,
              softWrap: false,style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),)),
          subtitle: Text(maillist[index].body,overflow: TextOverflow.ellipsis,softWrap: false,style: TextStyle(fontSize: 15.0),),
        );
     }
   );
  }
}
