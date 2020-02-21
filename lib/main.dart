import 'package:flutter/material.dart';
import 'screens/login.dart';
//import 'package:flutter/services.dart';

void main() => runApp(VisitorApp());

class VisitorApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays ([]);
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.purpleAccent,
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
//        textTheme: TextTheme(
//          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//          body1: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
//        ),
      ),
      home: LoginPg(),
    );
  }
}