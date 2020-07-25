import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewMail extends StatefulWidget {
  ViewMail({this.image,this.name, this.caption, this.body,this.id,this.timestamp,this.isRead,this.attachments,this.mail});

  final List<dynamic> attachments;
  final String body;
  final String caption;
  final String id;
  final String image;
  final String isRead;
  final String mail;
  final String name;
  final Timestamp timestamp;

  @override
  _ViewMailState createState() => _ViewMailState();
}

class _ViewMailState extends State<ViewMail> {
  //File _filePath;

  @override
  Widget build(BuildContext context) {

     final List<dynamic> _filePath = widget.attachments;

     Widget attachments(){

      if(widget.attachments == null){
        return Text('no data',style: TextStyle(color: Colors.transparent),);
      }
      else{

return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        child: Column(
          children : <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left:15.0,top: 15.0,bottom: 15.0),
              child: Text('attachments : ',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
            ) ,
            GridView.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _filePath.length,
            itemBuilder: (context, index){
              return Card(
              child: Image.network(widget.attachments[index]),
              );
            },
            )
          ]
        )
      );
    }
  }

  Timestamp time = widget.timestamp;
  DateTime date = time.toDate();

    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.blue[300],),
      body: Container(
        child: ListView(
          children :<Widget>[
          Column(
            children: <Widget>[

                Container(
                  height: 180.0,
                  width: 1000.0,
                  color: Colors.blue[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      ClipOval(
                          child: Image.network(
                            widget.image ?? '',
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
                      child: Text( widget.mail ?? 'sender mail', overflow: TextOverflow.ellipsis,softWrap: false, style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic))
                      ),
                      SizedBox(height:5.0),
                      Container(
                      margin: EdgeInsets.only(right:15.0),
                      child: Text('at ${date.toString()}', overflow: TextOverflow.ellipsis,softWrap: false,style: TextStyle(fontSize: 15.0,))
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
