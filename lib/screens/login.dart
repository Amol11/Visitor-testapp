import 'package:flutter/material.dart';
import 'package:visitor_testapp/common/widgets/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitor_testapp/common/widgets/snackbar.dart';
import 'package:visitor_testapp/common/widgets/alertDialog.dart';
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
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _phoneNo,
                keyboardType: TextInputType.numberWithOptions(),
                validator: (String value) {
                  if (value.isEmpty || value.length != 10) {
                    return "Invalid phone number";
                  } else
                    return null;
                },
                //autovalidate: true,
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
                      child: getImageWidget(_selectedFile),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      setState(
                        () {
                          getImage(ImageSource.camera);
                          cameraButtonTxt = 'Reupload Photo';
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                      disabledColor: Colors.white12,
                      elevation: 5.0,
                      color: Colors.purple,
                      child: Text(
                        'Remove Photo',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                      onPressed:
                          _selectedFile == null ? null : _buttonController),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.purple,
                child: Text('Submit',
                    style: TextStyle(fontSize: 15.0, color: Colors.white)),
                onPressed: () {
                  setState(() {
                    final FormState form = _formKey.currentState;
                    form.save();
                    if (_selectedFile == null)
                      showSnackBar('Photo required!', _scaffoldKey);
                    else if(_selectedFile != null){
                      if (_formKey.currentState.validate()) {
                        showAlert('Do you really want to send an OTP to +91${_phoneNo.text} ?', 'Confirmation', context);
                        showSnackBar('Done', _scaffoldKey);
                      }
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buttonController() {
    setState(() {
      _selectedFile = null;
    });
  }

  getImage(ImageSource source) async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        this.setState(() {
          _selectedFile = image;
        });
      }
    } catch (e) {
      showSnackBar('Error: Camera inaccessible.', _scaffoldKey);
    }
  }
}
