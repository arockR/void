import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudModel{
  final String email;
  final CollectionReference userCollection = Firestore.instance.collection('User');

  FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageReference _storageReference = FirebaseStorage.instance.ref();

  CloudModel({this.email});

  Future sendToStorage()async{

     List<String> _imgurls = List();

     List<File> files = await FilePicker.getMultiFile();
     files.forEach((file)async {
      String filename =  file.path.split('/').last; 
      StorageUploadTask uploadTask = _storageReference.child('/$email/$filename').putFile(file);
      final url =await(await uploadTask.onComplete).ref.getDownloadURL();
      final imgurl = url;
      _imgurls.add(imgurl);
      FirebaseUser user =await _auth.currentUser();
      return await userCollection.document(user.email).collection('vault').document().setData({'url' : _imgurls});
      }
      );
  }
}