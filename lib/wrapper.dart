import 'package:flutter/material.dart';
import 'package:mailee/auth/screen_controller.dart';
import 'package:mailee/auth/user.dart';
import 'package:mailee/pages/home.dart';
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