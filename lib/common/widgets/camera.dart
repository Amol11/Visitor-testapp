import 'package:flutter/material.dart';
import 'dart:io';

Widget getImageWidget(File _selectedFile) {
  if (_selectedFile != null) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: new EdgeInsets.all(10.0),
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white70),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.file(
                _selectedFile,
                width: 250,
                height: 250,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ],
    );
  } else {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: new EdgeInsets.all(10.0),
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white70),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'images/camera_default.png',
                width: 250,
                height: 250,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
