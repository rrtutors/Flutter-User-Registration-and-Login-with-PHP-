import 'package:flutter/material.dart';

import 'package:rest_app/screens/home.dart';
import 'package:rest_app/screens/signin.dart';
import 'package:rest_app/screens/signup.dart';

import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "assets/background.jpg",
            fit: BoxFit.fill,
          ),
        ),
        (_loginStatus==1)?Home():SignIn()
      ],),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => new SignIn(),
        '/signup': (BuildContext context) => new SignUp(),
        '/home': (BuildContext context) => new Home(),
      },
    );
  }
var _loginStatus=0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getInt("value");


    });
  }
}

