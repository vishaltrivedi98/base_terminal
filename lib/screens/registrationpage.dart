import 'package:bash_terminal/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController emailInputController;
  TextEditingController passInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    passInputController = new TextEditingController();

    super.initState();
  }

  String emailValidator(String value) {
    String pattern = "[a-zA-z0-9._-]+@[a-z]+\\.+[a-z]+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bash Terminal",
          style: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Registration",
                  style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      labelStyle:
                          TextStyle(fontSize: 15.0, color: Colors.black),
                      hintText: "Enter your Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailInputController,
                    validator: emailValidator,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.black),
                    hintText: "Enter your Password ",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: passInputController,
                  validator: pwdValidator,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 150,
                  height: 30,
                  child: RaisedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      elevation: 20,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1.5)),
                      onPressed: () {
                        if (_registerFormKey.currentState.validate()) {
                          try {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: passInputController.text,
                                )
                                .then((currentUser) => Firestore.instance
                                    .collection("user")
                                    .document(currentUser.user.uid)
                                    .setData(
                                      {
                                        "uid": currentUser.user.uid,
                                        "email": emailInputController.text,
                                      },
                                    )
                                    .then(
                                      (result) => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (_) => false),
                                        emailInputController.clear(),
                                      },
                                    )
                                    .catchError((err) => print(err)));
                          } catch (err) {
                            print(err);
                          }
                        } else {}
                      }),
                ),
                SizedBox(
                  height: 50,
                ),
                Text("Already have an account "),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Text("Login here!"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}