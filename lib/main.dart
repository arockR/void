import 'package:flutter/material.dart';
import 'package:mailee/auth/auth.dart';
import 'package:mailee/auth/user.dart';
import 'package:mailee/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: Authentication().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
      ),
    );  
  }
}
