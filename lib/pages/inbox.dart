import 'package:flutter/material.dart';

class Inbox extends StatelessWidget {
  Inbox({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body: InboxUi()
    );
  }
}


class InboxUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
          scrollDirection: Axis.vertical,
          children:<Widget>[
        Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onLongPress: (){},
            child: ListTile(
              leading: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                  SizedBox(width:10.0),
                  Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
                ],
              ),
              subtitle: Text(
                'application regarding your job from mailee,application regarding your job from mailee',
                style: TextStyle(
                  fontSize: 15.0
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(30.0)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('arock',style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width:10.0),
                Text('application regarding your job from mailee',style: TextStyle(fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.w500),),
              ],
            ),
            subtitle: Text(
              'application regarding your job from mailee,application regarding your job from mailee',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),
          SizedBox(height: 15.0,),

          
        ],
      ),
    ]
  );
 }
}