import 'package:bash_terminal/screens/loginpage.dart';
import 'package:bash_terminal/screens/registrationpage.dart';
import 'package:bash_terminal/screens/splashpage.dart';
import 'package:bash_terminal/screens/welcomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bash Terminal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => Splash(),
        '/welcome': (BuildContext context) => Welcome(),
        '/registration': (BuildContext context) => Registration(),
        '/login': (BuildContext context) => Login(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
