//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/material.dart';
//import 'package:z_meet/Screens/Auth/Login.dart';
//import 'package:z_meet/Screens/IntroPage.dart';
//
//import 'Screens/HomePage.dart';
//
//void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  runApp(new MaterialApp(
//    home: HomePage(),
//    debugShowCheckedModeBanner: false,
//    theme: new ThemeData(),
//  ));
//}
//
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//  bool isSigned = false;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    FirebaseAuth.instance.authStateChanges().listen((user) {
//      if(user!=null){
//        setState(() {
//          isSigned = true;
//        });
//      }
//      else{
//        setState(() {
//          isSigned = false;
//        });
//      }
//    });
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.black,
//      body: isSigned == false?IntroPage():HomePages()
//    );
//  }
//}
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:z_meet/Screens/HomePage.dart';
import 'package:z_meet/Screens/IntroPage.dart';

import 'Screens/Auth/Login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    title: 'ZMeet',

  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isSigned = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user!=null){
        setState(() {
          isSigned = true;
        });
      }
      else{
        setState(() {
          isSigned = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isSigned == false?IntroPage():HomePages()
    );
  }
}





