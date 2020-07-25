import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CloudVault extends StatefulWidget {
  @override
  _CloudVaultState createState() => _CloudVaultState();
}

class _CloudVaultState extends State<CloudVault> {
  final StorageReference storageRef = FirebaseStorage.instance.ref();

  FirebaseAuth _auth = FirebaseAuth.instance;
  String _extension;
  bool _multiPick = false;
  String _path;
  Map<String,String> _paths;
  //FileType _pickType;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];

  openFileExplorer()async{

    try{
      _path = null;
      if(_multiPick == true){
        _paths = await FilePicker.getMultiFilePath(type: FileType.any);
      }
      else{
        _path = await FilePicker.getFilePath(type: FileType.any);
      }

      uploadToFirebase();

    }on PlatformException catch(error){
      print('$error,cannot get file Explorer');
    }

    if(!mounted){return;}
   }

   uploadToFirebase(){
     if(_multiPick){
       _paths.forEach((fileName, filePath) { upload(fileName,filePath); });
     }
     else{
       String fileName = _path.split('/').last;
       String filePath = _path;
       upload(fileName, filePath);
       print('$filePath and $fileName');
     }
   }

      upload(fileName,filePath){
     _extension = fileName.toString().split('.').last;
     StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);

      //CloudModel().sendToVault(filePath);

     final StorageUploadTask uploadTask = storageReference.putFile(

       File(filePath), StorageMetadata(contentType: '$_extension')//$_pickType/
     );
   print(upload(fileName, filePath));
     setState(() {
       _tasks.add(uploadTask);
     });
   }

   uploadfile()async{
     FirebaseUser user = await _auth.currentUser();
     final email = user.email;
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     key :_scaffoldKey,
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[

                Container(
                  //color: Colors.black12,
                  child: ListTile(
                    title: Text('Images',style: TextStyle(fontSize:20.0,fontWeight: FontWeight.w400),),
                    onTap: (){},
                  ),
                ),
                Container(
                  //color: Colors.black12,
                  child: ListTile(
                    title: Text('Videos',style: TextStyle(fontSize:20.0,fontWeight: FontWeight.w400),),
                    onTap: (){},
                  ),
                ),
                Container(
                //color: Colors.black12,
                  child: ListTile(
                    title: Text('Audios',style: TextStyle(fontSize:20.0,fontWeight: FontWeight.w400),),
                    onTap: (){},
                  ),
                ),
                Container(
                  //color: Colors.black12,
                  child: ListTile(
                    title: Text('Documents',style: TextStyle(fontSize:20.0,fontWeight: FontWeight.w400),),
                    onTap: (){},
                  ),
                ),
                Container(
                  //color: Colors.black12,
                  child: ListTile(
                    title: Text('Others',style: TextStyle(fontSize:20.0,fontWeight: FontWeight.w400),),
                    onTap: (){},
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top:30.0,left:15.0,bottom: 20.0),
                  alignment: Alignment.bottomLeft,
                  child: Text('Recent Uploads',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)),
                ),

                ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 80, // Set as you want or you can remove it also.
                      maxHeight: double.infinity,
                    ),
                    child: Container(
                      child: GridView(
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                         
                          

                        ],
                      ),
                    ),
                  ),

                  FloatingActionButton(
                    child: Icon(Icons.add), 
                    onPressed: (){uploadfile();}
                  ),
              ],
            )
            

          ],
        ),
      ),
    );
  }
}
