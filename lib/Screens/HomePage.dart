import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:z_meet/Screens/ProfileScreen.dart';
import 'package:z_meet/Screens/VideoCall.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages>  {


  List PageView = [
    Videocall(),
    ProfileScreen()
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: new BottomNavigationBar(
       selectedItemColor: Colors.blue,
       unselectedItemColor: Colors.grey,
       selectedLabelStyle: new TextStyle(color: Colors.blue),
       unselectedLabelStyle: new TextStyle(color: Colors.grey),
       currentIndex: page,
       onTap: (index){
         setState(() {
           page = index;
         });
       },
       items: [
         new BottomNavigationBarItem(
           title: new Text('Video Call'),
           icon: new Icon(Icons.video_call)
         ),
         new BottomNavigationBarItem(
           title: new Text('Profile'),
           icon: new Icon(Icons.person)
         )
       ],
     ),

      body:PageView[page]
    );
  }
}
