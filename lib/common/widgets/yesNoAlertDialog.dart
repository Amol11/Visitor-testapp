import 'package:flutter/material.dart';

showAlert(String dialogString, String dialogTitle, context, [onYesPress]) {
  AlertDialog dialog = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    title: Text(
      dialogTitle,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20.0),
    ),
    content: Text(
      dialogString,
      textAlign: TextAlign.justify,
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'No',
          style: TextStyle(color: Colors.purpleAccent),
        ),
      ),
      FlatButton(
        onPressed: () {
          onYesPress();
          Navigator.of(context).pop();
        },
        child: Text(
          'Yes',
          style: TextStyle(color: Colors.purpleAccent),
        ),
      ),
    ],
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
