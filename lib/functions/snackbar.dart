import 'package:flutter/material.dart';

void showSnackBar(String message,final GlobalKey<ScaffoldState> _scaffoldKey) {
  var snackBar = SnackBar(
    backgroundColor: Colors.purple,
    content: Text(
      message,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white
      ),
    ),
  );
  _scaffoldKey.currentState.showSnackBar(snackBar);
}