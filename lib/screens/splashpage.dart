import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'welcomepage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Widget screen = new SplashScreenView(
      imageSrc: "assets/images/bash.jpg",
      home: Welcome(),
      duration: 8000,
      imageSize: 200,
      text: "Bash Terminal",
      textType: TextType.ScaleAnimatedText,
      textStyle: GoogleFonts.raleway(
        fontSize: 30.0,
        color: Colors.black,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: screen,
    );
  }
}