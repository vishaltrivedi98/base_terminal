import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bash Terminal",
                style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white),
      body: Container(
        padding: EdgeInsets.all(90),
        child: Column(
          children: <Widget>[
            Text(
              "Welcome",
              style: GoogleFonts.raleway(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            Column(
              children: <Widget>[],
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 200,
              child: RaisedButton(
                  color: Colors.white,
                  elevation: 10,
                  child: Text(
                    'Registration',
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context, "/registration");
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              child: RaisedButton(
                  color: Colors.white,
                  elevation: 10,
                  child: Text(
                    'Login',
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}