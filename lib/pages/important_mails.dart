import 'package:flutter/material.dart';
import 'package:mail/models/mail/con_model.dart';
import 'package:mail/models/mail/mail_model.dart';
import 'package:mail/models/user/user.dart';
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

    final maillist = Provider.of<List<GetMails>>(context);

    return ListView.builder(
        itemCount: maillist.length,
        itemBuilder: (context , index){

          return ListTile(
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