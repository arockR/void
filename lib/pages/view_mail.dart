import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewMail extends StatefulWidget {
  ViewMail({this.name, this.caption, this.body,this.id,this.timestamp,this.isRead});

  final String body;
  final String caption;
  final String id;
  final String isRead;
  final String name;
  final Timestamp timestamp;

  @override
  _ViewMailState createState() => _ViewMailState();
}

class _ViewMailState extends State<ViewMail> {
  File _filePath;

  @override
  Widget build(BuildContext context) {

     List<File> _filePath;

     Widget attachments(){

      if(_filePath == null){
        return Text('');
      }
      else{

return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 80, // Set as you want or you can remove it also.
          maxHeight: double.infinity,
        ),
        child: Container(
          child: GridView.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _filePath.length,
            itemBuilder: (context, index){

              return Card(
              child: Image.file(_filePath[index],),
              );
            },
            
          

            )
            )
            );
      }
    }


    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: Container(
        child: ListView(
          children :<Widget>[
          Column(
            children: <Widget>[

                Container(
                  height: 180.0,
                  width: 1000.0,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      ClipOval(
                          child: Image.asset(
                            "assets/profile.png",
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),

                      SizedBox(height: 5.0,),

                      Container(
                        margin: EdgeInsets.only(right:15.0),
                        child: Text(widget.name,style: TextStyle(fontSize: 20.0))
                        ),

                      SizedBox(height:5.0),

                      Container(
                      margin: EdgeInsets.only(right:15.0),
                      child: Text('arock@mailee.com', overflow: TextOverflow.ellipsis,softWrap: false, style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic))
                      ),
                      SizedBox(height:5.0),
                      Container(
                      margin: EdgeInsets.only(right:15.0),
                      child: Text('at ', overflow: TextOverflow.ellipsis,softWrap: false,style: TextStyle(fontSize: 15.0,fontStyle: FontStyle.italic))
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left:10.0),
                  child: Text(
                    widget.caption,
                    style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0) ,),
                ),
                SizedBox(height: 20.0,),
                Container(
                  color: Colors.black12,
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.all(15.0),
                  child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                      widget.body,
                      style:TextStyle(fontSize: 16.0,letterSpacing: .3, height: 1.5) ,),
                  ),
                ),
            ],
          ),

           attachments()
          ]
        ),
      )
    );
  }
}
