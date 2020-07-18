import 'package:flutter/material.dart';
import 'package:mail/auth/screen_controller.dart';
import 'package:mail/models/user/user.dart';
import 'package:mail/pages/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return AuthControll();
    }
    else{
      return Home();
    }
  }
}