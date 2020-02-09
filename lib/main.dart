import 'package:flutter/material.dart';
import 'screens/login.dart';
//import 'package:flutter/services.dart';

void main() => runApp(VisitorApp());

class VisitorApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays ([]);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoginPg(),
    );
  }
}