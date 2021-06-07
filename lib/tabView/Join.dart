import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width:300,
              child:  new Text('Create Code And Share With Friends',style: new TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
            ),
          ),
          SizedBox(height:30,),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text('Code :',style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              new Text(code,style:new TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple) ,)
            ],
          ),
          SizedBox(height: 25,),
          new RaisedButton(
            child: new Text('Create Code',style: new TextStyle(color: Colors.white),),
            color: Colors.lightBlue,
            onPressed: (){
              createCode();
            },
          )
        ],
      ),
    );
  }

   createCode() {
    setState(() {
      code = Uuid().v1().substring(0,6);
    });
   }
}
