import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mail/models/mail/con_model.dart';

class MailService{ 
  final String docid;
  final String email;
  final CollectionReference idCollection = Firestore.instance.collection('id');
  final String mailId;
  final String tmailId;
  final String uid;
  final CollectionReference userCollection = Firestore.instance.collection('User');

  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> _imgurls = List();
  final StorageReference _storageReference = FirebaseStorage.instance.ref();

  MailService({this.uid,this.mailId,this.tmailId,this.email,this.docid});


  //setting data to firestore

  Future sendMail(String tmail, String caption, String body, Timestamp timestamp, bool isRead )async{

    FirebaseUser user =await _auth.currentUser();

    return await userCollection.document(user.email).collection('mails').document('1').collection('sent').document().setData({
      'tmail' : tmail,
      'caption' : caption,
      'body' : body,
      'timestamp' : timestamp,
      'isRead' : isRead,
    });
  }

  Future sendTarget(String name, String image, String mail, String caption, String body, Timestamp timestamp, bool isRead )async{

    return await userCollection.document(tmailId).collection('mails').document('1').collection('inbox').document().setData({

      'name' : name,
      'image' : image,
      'mail' : mail,
      'caption' : caption,
      'body' : body,
      'timestamp' : timestamp,
      'isRead' : isRead
    });
  }

  Future saveToImportant(String name, String image, String mail, String caption, String body )async{

    return await userCollection.document(email).collection('mails').document('1').collection('important').document().setData({

      'name' : name,
      'image' : image,
      'mail' : mail,
      'caption' : caption,
      'body' : body
    });
  }

  Future moveToBin(String name, String image, String mail, String caption, String body )async{

    return await userCollection.document(email).collection('mails').document('1').collection('bin').document(docid).setData({

      'name' : name,
      'image' : image,
      'mail' : mail,
      'caption' : caption,
      'body' : body,
    });
  }

  Future signUpMail(String mail, String fname, String lname )async{

    return await idCollection.document().setData({
      'mailId' : mail,
      'firstName' : fname,
      'lastName' : lname
    });
  }

  Future setColor(String mail, String fname, String lname, String id)async{

     final doclink = idCollection.document();

    return doclink.setData({
      'mailId' : mail,
      'firstName' : fname,
      'lastName' : lname,
    });
  }




    //getting stream operation



   List<GetMails> _mailList(QuerySnapshot snapshot){
    DocumentReference docRef = userCollection.document(email).collection('mails').document('1').collection('inbox').document();
    return snapshot.documents.map((doc){
      return GetMails(
        name: doc.data['name'], 
        mail: doc.data['mail'], 
        image: doc.data['image'], 
        caption: doc.data['caption'], 
        body: doc.data['body'],
        timestamp: doc.data['timestamp'],
        id: docRef.documentID,
       // isRead: doc.data['isRead']
        );
    } ).toList();
  } 

  Stream<List<GetMails>> get mail {
    return userCollection.document(email).collection('mails').document('1').collection('inbox').snapshots().map(_mailList);
  }

  List<GetMails> _importantMailList(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return GetMails(
        name: doc.data['name'], 
        mail: doc.data['mail'], 
        image: doc.data['image'], 
        caption: doc.data['caption'], 
        body: doc.data['body']
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
        body: doc.data['body']
        );
    } ).toList();
  } 

  Stream<List<GetMails>> get bin {
    return userCollection.document(email).collection('mails').document('1').collection('bin').snapshots().map(_binList);
  }
}