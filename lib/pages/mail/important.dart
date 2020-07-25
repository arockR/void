import 'package:flutter/material.dart';
import 'package:mailee/auth/user.dart';
import 'package:mailee/models/mail/mail.dart';
import 'package:mailee/models/mail/mail_model.dart';
import 'package:mailee/pages/mail/view_mail.dart';
import 'package:provider/provider.dart';

class ImportantMails extends StatefulWidget {
  @override
  _ImportantMailsState createState() => _ImportantMailsState();
}

class _ImportantMailsState extends State<ImportantMails> {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    return StreamProvider<List<GetMails>>.value(
      value: MailService(email: user.email).impotantMails,
      child: Scaffold(
        appBar: AppBar(),
        body: ImportantMailUi(),
      )
    );
  }
}


class ImportantMailUi extends StatefulWidget {
  @override
  _ImportantMailUiState createState() => _ImportantMailUiState();
}

class _ImportantMailUiState extends State<ImportantMailUi> {
  @override
  Widget build(BuildContext context) {

    var body;
    final maillist = Provider.of<List<GetMails>>(context);
    final user = Provider.of<User>(context);
    //final CollectionReference userCollection = Firestore.instance.collection('User');
    
    // restored message

  void onpressToImportant() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("mail restored"),
      backgroundColor: Colors.blueAccent,
    ),
    );
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
                          setState(() {body = maillist[index].body; });
                            MailService(tmailId: user.email).sendTarget(user.name, maillist[index].image, user.email, maillist[index].caption, maillist[index].body, maillist[index].timestamp, true);
                            MailService(body: body,email: user.email).deleteimportantDoc();
                            Navigator.pop(context);
                            onpressToImportant();
                        },
                        child: Container(padding: EdgeInsets.all(10.0), child: Text('restore',style: TextStyle(fontSize: 18.0),)),
                      ),
                    );
                });
            },
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text( maillist[index].name , overflow: TextOverflow.ellipsis,softWrap: false, style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text(maillist[index].caption , overflow: TextOverflow.ellipsis,softWrap: false,style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              maillist[index].body,
              overflow: TextOverflow.ellipsis,softWrap: false,
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          );
      }
    );
  }
}