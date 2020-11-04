import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TextEditingController command = TextEditingController();
  var input;
  @override
  void initState() {
    super.initState();
    firestoreInstance.collection("users").doc(firebaseUser.uid).set({
      "Result": "",
      "statusCode": "",
    });
  }

  getOutput(input) async {
    var url = 'http://192.168.43.129/cgi-bin/linux.py?x=$input';
    var result = await http.get(url);
    var output = json.decode(result.body);

    await firestoreInstance.collection("users").doc(firebaseUser.uid).set({
      "Result": output['Result'],
      "statusCode": output['statusCode']
    }).then((_) => print("Sucess"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                "Bash Terminal",
                style: GoogleFonts.raleway(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                      child: Center(
                          child: Text("Terminal",
                              style: GoogleFonts.raleway(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: command,
                        decoration: InputDecoration(
                          labelText: "Enter Your command",
                          focusColor: Colors.black,
                          filled: true,
                          labelStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Do not leave blank';
                          }
                          input = value;
                          return null;
                        },
                      ),
                    ),
                    Center(
                        child: FloatingActionButton.extended(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          getOutput(input);
                        }
                      },
                      label: Text("Run"),
                      backgroundColor: Colors.black,
                      icon: Icon(Icons.fast_forward),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(width: 0.5, color: Colors.black),
                ),
                child: Text(
                  " Output:-",
                  style: GoogleFonts.raleway(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              StreamBuilder(
                stream: firestoreInstance
                    .collection("users")
                    .doc(firebaseUser.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Text("No Data");
                  else {
                    var info = snapshot.data.data();
                    return SingleChildScrollView(
                      child: Container(
                        width: (MediaQuery.of(context).size.width) * 0.95,
                        height: 400.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            (info['Result'] != null) ? info['Result'] : "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black, style: BorderStyle.solid)),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}