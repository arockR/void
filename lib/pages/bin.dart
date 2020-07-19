import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mail/models/mail/con_model.dart';
import 'package:mail/models/mail/mail_model.dart';
import 'package:mail/models/user/user.dart';
import 'package:mail/pages/view_mail.dart';
import 'package:provider/provider.dart';

class Bin extends StatefulWidget {
  @override
  _BinState createState() => _BinState();
}

class _BinState extends State<Bin> {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    showWarning()async{
      return showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){

          return AlertDialog(
            title: Text('Confirm Delete All'),
            content: Text('This action cannot be reversed'),
            actions: <Widget>[
              FlatButton(
                onPressed: ()async{
                  final email = user.email;
                  CollectionReference collectionReference = Firestore.instance.collection('User').document(email)
                          .collection('mails').document('1').collection('bin');
                  
                  collectionReference.getDocuments().then((value) => {
                  value.documents.forEach((element) {
                  Firestore.instance.collection('User').document(email)
                          .collection('mails').document('1').collection('bin').document(element.documentID).delete();
                    })
                  });
                  Navigator.pop(context);
                }, 
                child: Text('Yes')),

              FlatButton(
                onPressed: (){Navigator.pop(context);}, 
                child: Text('Cancel'))
            ],
          );
      });
    }

    //FirebaseUser user = await _auth.currentUser();
    return StreamProvider<List<GetMails>>.value(
      value: MailService(email: user.email).bin,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: (){
                     showWarning();
                  },
                )
              ],
            )
          ],
        ),
        body: BinUi(),
      )
    );
  }
}


class BinUi extends StatefulWidget {
  @override
  _BinUiState createState() => _BinUiState();
}

class _BinUiState extends State<BinUi> {
  @override
  Widget build(BuildContext context) {

    emptyScreen(){
      return Center(child: Text('Bin is Empty',style: TextStyle(fontSize: 18.0, color: Colors.black54),),);
    }

    final binlist = Provider.of<List<GetMails>>(context);


    return ListView.builder(
        itemCount:binlist.length != null ? binlist.length : emptyScreen(),
        itemBuilder: (context , index){

          return ListTile(
              onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewMail(name:binlist[index].name, caption: binlist[index].caption , body:binlist[index].body, id:binlist[index].id, timestamp:binlist[index].timestamp, isRead:binlist[index].isRead)));
            },
            
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text( binlist[index].name , overflow: TextOverflow.ellipsis,softWrap: false, style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text(binlist[index].caption , overflow: TextOverflow.ellipsis,softWrap: false,style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              binlist[index].body,
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