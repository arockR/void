import 'package:flutter/material.dart';
import 'package:mail/wrapper.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'models/user/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User>.value(
        value: Authentication().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
      ),
    );
  }
}