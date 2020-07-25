import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailee/models/mail/mail_model.dart';

class MailService{ 
  
  final String docid;
  final String email;
  final String mailId;
  final String tmailId;
  final String uid;
  final String body;
  MailService({this.uid,this.mailId,this.tmailId,this.email,this.docid,this.body});

  final CollectionReference userCollection = Firestore.instance.collection('User');
  final CollectionReference idCollection = Firestore.instance.collection('id');

  FirebaseAuth _auth = FirebaseAuth.instance;


  //setting data to firestore

  Future sendMail(String tmail, String caption, String body, Timestamp timestamp,List<dynamic> attachments, bool isRead )async{

    FirebaseUser user =await _auth.currentUser();

    return await userCollection.document(user.email).collection('mails').document('1').collection('sent').document().setData({
      'sent to' : tmail,
      'caption' : caption,
      'body' : body,
      'sent at' : timestamp,
      'attachments' : attachments,
      'isRead' : isRead,
    });
  }

  Future deleteimportantDoc()async{
    return await Firestore.instance.collection('User').document(email).collection('mails').document('1').collection('important')
    .where('body', isEqualTo:  body).getDocuments().then((value){value.documents.first.reference.delete();});
  }

   Future deletesavedDoc()async{
    return await Firestore.instance.collection('User').document(email).collection('mails').document('1').collection('saved')
    .where('body', isEqualTo:  body).getDocuments().then((value){value.documents.first.reference.delete();});
  }

  Future sendTarget(String name, String image, String mail, String caption, String body, Timestamp timestamp, bool isRead )async{

      
    return await userCollection.document(tmailId).collection('mails').document('1').collection('inbox').document().setData({

      'sendername' : name,
      'senderimage' : image,
      'senderemail' : mail,
      'caption' : caption,
      'body' : body,
      'sent at' : timestamp,
      'isRead' : isRead,
    },merge: true).whenComplete(() { print('success');});
  }

  Future saveToImportant(String id, String name, String image, String mail, String caption, String body, Timestamp timestamp, List<dynamic> attachments )async{

    return await userCollection.document(email).collection('mails').document('1').collection('important').document().setData({

      'name' : name,
      'senderimage' : image,
      'mail' : mail,
      'caption' : caption,
      'body' : body,
      'sent at' : timestamp,
      'attachments' : attachments,
      'id' : id,
    });
  }

  Future moveToBin(String name, String image, String mail, String caption, String body, Timestamp timestamp )async{

    return await userCollection.document(email).collection('mails').document('1').collection('bin').document(docid).setData({

      'name' : name,
      'senderimage' : image,
      'mail' : mail,
      'caption' : caption,
      'body' : body,
      'sent at' : timestamp,
    });
  }

  Future signUpMail(String mail, String fname, String lname )async{

    return await idCollection.document().setData({
      'mailId' : mail,
      'firstName' : fname,
      'lastName' : lname
    });
  }




    //getting stream operation



   List<GetMails> _mailList(QuerySnapshot snapshot){
    DocumentReference docRef = userCollection.document(email).collection('mails').document('1').collection('inbox').document();
    return snapshot.documents.map((doc){
      return GetMails(
        name: doc.data['sendername'], 
        mail: doc.data['senderemail'], 
        image: doc.data['senderimage'] ?? 'https://firebasestorage.googleapis.com/v0/b/mail-250f4.appspot.com/o/profile.png?alt=media&token=f8c6f468-843b-4818-923b-f026d4335ff0', 
        caption: doc.data['caption'], 
        body: doc.data['body'],
        timestamp: doc.data['sent at'],
        id: docRef.documentID,
        attachments : doc.data['attachements']
       // isRead: doc.data['isRead']
        );
    } ).toList();
  } 

  Stream<List<GetMails>> get mail {
    return userCollection.document(email).collection('mails').document('1').collection('inbox').orderBy('sent at',descending: false).snapshots().map(_mailList);
  }


  List<GetMails> _importantMailList(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return GetMails(
        name: doc.data['name'], 
        mail: doc.data['mail'], 
        image: doc.data['image'], 
        caption: doc.data['caption'], 
        body: doc.data['body'],
        timestamp: doc.data['sent at'],
        attachments: doc.data['attachements'],
        );
    } ).toList();
  } 

  Stream<List<GetMails>> get impotantMails {
    return userCollection.document(email).collection('mails').document('1').collection('important').snapshots().map(_importantMailList);
  }

    List<GetMails> _binList(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return GetMails(
        name: doc.data['name'], 
        mail: doc.data['mail'], 
        image: doc.data['image'], 
        caption: doc.data['caption'], 
        body: doc.data['body'],
        timestamp: doc.data['sent at'],
        attachments: doc.data['attachements'],
        );
    } ).toList();
  } 

  Stream<List<GetMails>> get bin {
    return userCollection.document(email).collection('mails').document('1').collection('bin').snapshots().map(_binList);
  }

  List<GetMails> _sentMailList(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return GetMails(
        name: doc.data['name'], 
        mail: doc.data['mail'], 
        image: doc.data['image'], 
        caption: doc.data['caption'], 
        body: doc.data['body'],
        timestamp: doc.data['sent at'],
        attachments: doc.data['attachements'],
        );
    } ).toList();
  } 

  Stream<List<GetMails>> get sentMails {
    return userCollection.document(email).collection('mails').document('1').collection('sent').snapshots().map(_sentMailList);
  }
  
}