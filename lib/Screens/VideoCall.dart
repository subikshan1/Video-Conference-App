import 'package:flutter/material.dart';
import 'package:z_meet/tabView/Create.dart';
import 'package:z_meet/tabView/Join.dart';


class Videocall extends StatefulWidget {
  @override
  _VideocallState createState() => _VideocallState();
}

class _VideocallState extends State<Videocall> with SingleTickerProviderStateMixin {

  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2,vsync: this);
  }

  //buildTabs
  buildTabs(String name){
    return Container(
      width: 150,
      height: 50,
      child: new Card(
        child: new Center(
          child: new Text(name,style: new TextStyle(color: Colors.black),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
      title: new Text('ZMEET',style: new TextStyle(color: Colors.white),),
      centerTitle: true,
      bottom: TabBar(
        controller: tabController,
        tabs: [
          buildTabs('Join Meeting'),buildTabs('Create Meeting')
        ],
      ),
    ),
    body: TabBarView(
      controller: tabController,
      children: [

        CreateMeeting(),
        JoinMeeting(),
      ],
    ),
    );
  }
}
