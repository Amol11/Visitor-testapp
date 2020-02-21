import 'package:flutter/material.dart';
import 'package:visitor_testapp/common/widgets/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitor_testapp/common/widgets/snackbar.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPgState();
}

class LoginPgState extends State<LoginPg> {
  File _selectedFile;
  var _formKey = GlobalKey<FormState>();
  var _cameraButtonTxt = 'Open Camera';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNo = TextEditingController();

  String verificationId;
  String smsCode;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value){
        print('Signed In');
        signIn();
      });
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value){
        print('Signed In');
        signIn();
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
      print('verified');
    };

    PhoneVerificationFailed veriFailed(AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_phoneNo.text}',
        timeout: const Duration(seconds: 0),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: null);
  }

  signIn() {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    FirebaseAuth.instance.signInWithCredential(credential)
        .then((user) {
          print('Welcome ${_phoneNo.text}');
//      showSnackBar('Welcome ${_phoneNo.text}',
//          _scaffoldKey);
    }).catchError((e) {
      print('Auth Credential Error: $e');
    });
  }

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
                decoration: InputDecoration(
                  prefixIcon:
                      IconButton(icon: Icon(Icons.phone), onPressed: null),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _phoneNo.clear();
                      }),
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
                      _cameraButtonTxt,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          getImage(ImageSource.camera);
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
                    else if (_selectedFile != null) {
                      if (_formKey.currentState.validate()) {
                        //verifyPhone();
                        showAlert(
                            'Do you really want to send an OTP to +91${_phoneNo
                                .text} ?', 'Confirmation', context);
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

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter the OTP'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pushReplacement(LoginPg);
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
                child: Text('Done'),
              )
            ],
          );
        });
  }

  showAlert(String dialogString, String dialogTitle, context) {
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
            verifyPhone();
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

  _buttonController() {
    setState(() {
      _selectedFile = null;
      _cameraButtonTxt = 'Open Camera';
    });
  }

  textValidator(String value) {
    if (value.isEmpty || value.length != 10) {
      return "Invalid phone number";
    } else
      return null;
  }

  getImage(ImageSource source) async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        this.setState(() {
          _selectedFile = image;
          _cameraButtonTxt = 'Reupload Image';
        });
      }
    } catch (e) {
      showSnackBar('Error: Camera inaccessible.', _scaffoldKey);
    }
  }
}
