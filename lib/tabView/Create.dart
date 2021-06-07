import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  TextEditingController roomController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  bool isVideo = true;
  bool isAudio = true;
  String name ='';
  String pic;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      name = snapshot.data()['UserName'];
      pic = snapshot.data()['ProfilePic'];
    });

  }


  //Join Meeting
  join() async {
    try{
      Map<FeatureFlagEnum,bool> featureflage = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if(Platform.isAndroid){
        featureflage[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      else if(Platform.isIOS){
        featureflage[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomController.text
        ..userDisplayName =
        textEditingController.text == ''?name:textEditingController.text
        ..audioMuted = isAudio
        ..videoMuted = isVideo;
      await JitsiMeet.joinMeeting(options);

    }
    catch(e){
      print(e);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        padding: EdgeInsets.symmetric(horizontal:16),
        child: SingleChildScrollView(
          child: new Column(
            children: [
              SizedBox(height: 24,),
              new Text('Room Code'),
              SizedBox(height: 20,),
              TextFormField(
                controller: roomController,
                decoration: new InputDecoration(
                  hintText: 'Enter Room Code'
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller:textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Leave as it is if you want default name'
                ),
              ),
              SizedBox(height: 16,),
              CheckboxListTile(
                value:isVideo,
                onChanged: (val){
                  setState(() {
                    isVideo = val;
                  });
                },
                title: new Text('Video Muted'),
              ),
              SizedBox(height: 16,),
              CheckboxListTile(
                value:isAudio,
                onChanged: (val){
                  setState(() {
                    isAudio = val;
                  });
                },
                title: new Text('Audio Muted'),
              ),
              SizedBox(height: 30,),
              Divider(),
              Container(
                color: Colors.lightBlue,
                width: double.maxFinite,
                height: 54,
                child: new RaisedButton(
                  color: Colors.lightBlue,
                  child: new Text('Join Meeting',style: new TextStyle(color: Colors.white),),
                  onPressed: (){
                    join();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
