import 'package:flutter/material.dart';
import 'dart:io';

Widget getImageWidget(File _selectedFile) {
  if (_selectedFile != null) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.file(
            _selectedFile,
            width: 250,
            height: 250,
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
  else {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.asset('images/camera_default.png',
            width: 250,
            height: 250,
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}