import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController passInputController;
  @override
  initState() {
    emailInputController = new TextEditingController();
    passInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
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
            key: _loginFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Login",
                  style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.black),
                    hintText: "Enter your Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailInputController,
                  validator: emailValidator,
                ),
                SizedBox(
                  height: 20,
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
                  height: 30,
                  width: 150,
                  child: RaisedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 20,
                    color: Colors.black,
                    onPressed: () {
                      if (_loginFormKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: emailInputController.text,
                              password: passInputController.text,
                            )
                            .then((currentUser) => Firestore.instance
                                .collection("user")
                                .document(currentUser.user.uid)
                                .get()
                                .then(
                                  (DocumentSnapshot result) =>
                                      Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  ),
                                )
                                .catchError((err) => print(err)))
                            .catchError((err) => print(err));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text("Don't have an account yet?"),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Text("Register here!"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/registration");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}