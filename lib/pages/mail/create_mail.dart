import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mailee/models/mail/mail.dart';

class CreateMail extends StatefulWidget {
  @override
  _CreateMailState createState() => _CreateMailState();
}

class _CreateMailState extends State<CreateMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Mail'),
      ),
      body: CreateMailUi()
    );
  }
}

class CreateMailUi extends StatefulWidget {
  @override
  _CreateMailUiState createState() => _CreateMailUiState();
}

class _CreateMailUiState extends State<CreateMailUi> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<File> _filePath;
  TextEditingController _receiverMailController = TextEditingController();
  TextEditingController _senderBodyController = TextEditingController();
  TextEditingController _senderCaptionController = TextEditingController();

    //reset form fields

    resetform(){
      setState(() {
        _receiverMailController.text = '';
        _senderCaptionController.text = '';
        _senderBodyController.text = '';
        _filePath = null;
      });
    }

    // send mail

    getUID() async {
      final FirebaseUser user = await _auth.currentUser();
      final tmailId = _receiverMailController.text.trim();
      final mailId = user.email;
      await MailService().sendMail(tmailId, _senderCaptionController.text, _senderBodyController.text, Timestamp.now(), null , false);
      await MailService(tmailId: tmailId).sendTarget(user.displayName, user.photoUrl, mailId,_senderCaptionController.text, _senderBodyController.text,Timestamp.now(),false)
      .whenComplete(()async => {
        resetform(),
        //await Fluttertoast.showToast(msg: 'mail sent', toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.TOP_LEFT,backgroundColor: Colors.green[300],textColor: Colors.white)
      });
    }

  @override
  Widget build(BuildContext context) {

    //get path to attachments

    getpath()async{
      List<File> files = await FilePicker.getMultiFile();
      setState(() {this._filePath = files;}); 
    }

    // show attachments

    Widget attachments(){

      if(_filePath == null){
         return Text('no files',style:TextStyle(color: Colors.transparent) ,);
      }
      else{
        return ConstrainedBox(
            constraints: BoxConstraints(minHeight: 80,maxHeight: double.infinity,),
            child: Container(
              child: GridView.builder(
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filePath.length,
                itemBuilder: (context, index){return Card(child: Image.file(_filePath[index],),);},
            )
          )
        );
      }
    }
    

    return Container(
      child: ListView(
        children: <Widget>[

         Column(
           children: <Widget>[

              SizedBox(height: 10.0,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
            child: TextField(
              controller: _receiverMailController,
              decoration: InputDecoration(
                labelText: 'To',
                labelStyle: TextStyle(fontSize: 19.0,color: Colors.black,fontWeight: FontWeight.w500)
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
            child: TextField(
              controller: _senderCaptionController,
              decoration: InputDecoration(
                labelText: 'caption*',
                labelStyle: TextStyle(fontSize: 19.0,color: Colors.black,fontWeight: FontWeight.w500)
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
            child: TextField(
              maxLines: 5,
              controller: _senderBodyController,
              decoration: InputDecoration(
                labelText: 'Body*',
                labelStyle: TextStyle(fontSize: 19.0,color: Colors.black,fontWeight: FontWeight.w500)
              ),
            ),
          ),

          SizedBox(height: 30.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('add files',style: TextStyle(fontSize: 16.0),),
                ),
                IconButton(
                icon: Icon(Icons.attach_file) , 
                onPressed: ()async{
                   getpath();   
                }
               ),
              ],
              ),

              Container(
                margin: EdgeInsets.only(right:30.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.black12,),
                child: IconButton(
                  color: Colors.green,
                  icon: Icon(Icons.send), 
                  onPressed: ()async{

                    if(_filePath == null){getUID();}
                    else{
                    
                   final CollectionReference userCollection = Firestore.instance.collection('User');
                   final StorageReference _storageReference = FirebaseStorage.instance.ref();
                   FirebaseUser user =await _auth.currentUser();
                   final email = user.email;
                   List<String> _imgurls = List();

                    _filePath.forEach((file)async {
                    String filename =  file.path.split('/').last; 
                    StorageUploadTask uploadTask = _storageReference.child('/$email/$filename').putFile(file);
                    final url =await(await uploadTask.onComplete).ref.getDownloadURL();
                    final imgurl = url;
                    _imgurls.add(imgurl);
                    final caption = _senderCaptionController.text;
                    final body = _senderBodyController.text;
                    final tmailId = _receiverMailController.text;
                    await MailService(uid: user.uid ,mailId: user.email).sendMail(tmailId, _senderCaptionController.text, _senderBodyController.text,Timestamp.now(),_imgurls,false);
                    return await userCollection.document(tmailId).collection('mails').document('1').collection('inbox')
                      .document().setData({
                        'sendername': user.displayName,
                        'senderemail': user.email,
                        'senderimage': user.photoUrl,
                        'sent at' : Timestamp.now(),
                        'caption' : caption,
                        'body' : body,
                        'attachements' : _imgurls,
                      })
                      .whenComplete(()async => {
                          resetform(),
                          // await Fluttertoast.showToast(msg: 'mail sent', toastLength: Toast.LENGTH_LONG,
                          // gravity: ToastGravity.TOP_LEFT,backgroundColor: Colors.green[300],textColor: Colors.white)
                        });
                    }
                    );
                    }
                    
                  }
                  ),
              ),
            ]
          )

           ],
         ),
             
          attachments(),


            ],
          )
        
      );
  }
}