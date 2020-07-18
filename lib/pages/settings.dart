import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('settings'),
        elevation: 0,
      ),
      body: SettingsUi(),
    );
  }
}


class SettingsUi extends StatefulWidget {
  @override
  _SettingsUiState createState() => _SettingsUiState();
}

class _SettingsUiState extends State<SettingsUi> {
  File userImage;

  @override
  Widget build(BuildContext context) {

    FirebaseAuth _auth = FirebaseAuth.instance;

    void onUpdated() {
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Profile has been updated"),
      backgroundColor: Colors.blueAccent,
       action: SnackBarAction(
          label: 'UNDO',onPressed: (){},)
    ),
    );
  }

    TextEditingController _nameController = TextEditingController();

    updateProfile()async{
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser user =await _auth.currentUser();
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = _nameController.text;
        updateInfo.photoUrl = userImage.path;
        final updated = user.updateProfile(updateInfo);
        updated.whenComplete(()=> onUpdated());
      }

   Widget  updateDialog(){
    return AlertDialog(
            content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Container(
                color: Colors.blue,
                child: InkWell(
                  onTap: ()async{
                    File image = await FilePicker.getFile(type: FileType.image);
                    setState(() {
                      userImage = image;
                    });
                  },
                  child: ClipOval(

                    child: Image.network(
                      "assets/profile.png",
                      width: 70.0,
                      height: 70.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 19.0,color: Colors.black,fontWeight: FontWeight.w400)
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  onPressed: (){updateProfile();}, 
                  child: Text('Update')),
              )


            ]
    )
  );}


    return ListView(
      children: <Widget>[

        Container(
          height: 250,
          color: Colors.blue,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              ClipOval(
                child: Image.asset(
                  "assets/profile.png",
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical:15.0),
                child: OutlineButton(
                  borderSide: BorderSide(width:1.0),
                  onPressed: () { showDialog(context: context , builder: (BuildContext context){
                    return updateDialog();
                  } );},
                  child:Text('update profile',style: TextStyle(fontSize: 15.0,),
                )
                ),
              )
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.only(left:20.0,top:20.0),
          child:ListTile(
            contentPadding: EdgeInsets.only(top: 5.0,bottom: 5.0),
            title: Text('Name',style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w400,color: Colors.black54),),
            subtitle: Text('arock',style: TextStyle(fontSize: 18.0,)),
          )
        ),

        Container(
          padding: EdgeInsets.only(left:20.0,top:20.0),
          child:ListTile(
            title: Text('Mailee Id',style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w400,color: Colors.black54),),
            contentPadding: EdgeInsets.only(top: 5.0,bottom: 5.0),
            subtitle: Text('arock@mailee.com',style: TextStyle(fontSize: 18.0,)),
          )
        ),

        Container(
          margin: EdgeInsets.only(top:30.0),
          child: InkWell(
            onTap: (){
              _auth.signOut();
            },
            child: Container(
              height: 30.0,
              color: Colors.redAccent,
              child: Center(child: Text('logout',style:TextStyle(color: Colors.white,fontSize: 18.0)))
            ),
          ),
        )


      ],
    );
  }
}