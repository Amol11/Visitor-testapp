import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';


Future uploadImage(TextEditingController _phoneNo, File _selectedFile) async{
  final StorageReference firebaseStorageRef = FirebaseStorage.instance
      .ref()
      .child('${_phoneNo.text}at${DateTime.now().millisecondsSinceEpoch}.jpg');
  StorageUploadTask task = firebaseStorageRef.putFile(_selectedFile);
}