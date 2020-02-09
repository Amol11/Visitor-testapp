import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class LoginPg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPgState();
}

class LoginPgState extends State<LoginPg> {
  File _selectedFile;
  var _formKey = GlobalKey<FormState>();
  var cameraButtonTxt = 'Open Camera';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays ([]);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Center(
          child: Text('Hello Visitor!'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _phoneNo,
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (String value) {
                    if (value.isEmpty || value.length != 10)
                      return 'Invalid phone number';
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: getImageWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Colors.purple,
                    child: Text(
                      cameraButtonTxt,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                    onPressed: () {
                      if (true) {
                        setState(
                              () {
                            cameraButtonTxt = 'Reupload Photo';
                            getImage(ImageSource.camera);
                          },
                        );
                      }
                    },
                  )),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.purple,
                  child: Text('Submit',
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  onPressed: () {
                    final FormState form = _formKey.currentState;
                    form.save();
                    if (_formKey.currentState.validate()) {
                      showSnackBar('Done');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String message) {
    var snackBar = SnackBar(
      backgroundColor: Colors.purple,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
      );
      this.setState(() {
        _selectedFile = cropped;
      });
    }
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        fit: BoxFit.cover,
      );
    }
    else {
      return Image.asset('image/camera_default.png',
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }
}
