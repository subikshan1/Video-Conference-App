import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:z_meet/Screens/Auth/Login.dart';


class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body: new  IntroductionScreen(
       pages:[
         PageViewModel(
             title: "WELCOME",
             body: "Welcome to Z-MEET the best video conferencing app",
             image: new Center(child: new Image(image: new AssetImage('images/welcome.png'),),),
             decoration: new PageDecoration(
                 titleTextStyle: new TextStyle(fontSize: 25,fontWeight: FontWeight.w800),
                 bodyTextStyle: new TextStyle()
             )
         ),
         PageViewModel(
             title: "JOIN OR START MEETING",
             body: "Easy to interface, join or starting meeting at fast time",
             image: new Center(child: new Image(image: new AssetImage('images/conference.png'),),),
             decoration: new PageDecoration(
                 titleTextStyle: new TextStyle(fontSize: 25,fontWeight: FontWeight.w800),
                 bodyTextStyle: new TextStyle()
             )
         ),
         PageViewModel(
             title: "SECURITY",
             body: "Your security is important for us.",
             image: new Center(child: new Image(image: new AssetImage('images/secure.jpg'),height: 230,),),
             decoration: new PageDecoration(
                 titleTextStyle: new TextStyle(fontSize: 25,fontWeight: FontWeight.w800),
                 bodyTextStyle: new TextStyle()
             )
         ),
       ],onDone: (){
         Navigator.push(context,new MaterialPageRoute(
           builder: (context)=>new Login()
         ));
     },
       onSkip:() {

       },
       showSkipButton: true,
       skip: new Icon(Icons.skip_next,size: 45,),
       next: new Icon(Icons.arrow_forward_ios,),
       done: new Text('Done',style: new TextStyle(),),
     ),);
  }
}
