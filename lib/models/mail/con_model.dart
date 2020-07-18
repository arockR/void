import 'package:cloud_firestore/cloud_firestore.dart';

class GetMails{
  final String body;
  final String caption; 
  final String id;
  final String image; 
  final String isRead;
  final String mail; 
  final String name; 
  final Timestamp timestamp;

  GetMails({this.name, this.mail, this.image, this.caption, this.body,this.id,this.timestamp,this.isRead}); 
}