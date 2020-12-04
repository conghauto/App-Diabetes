import 'package:diabetesapp/screens/more/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget{
  static String routeName = "/more_screen";
  @override
  _MoreScreenStateful createState() {
    return _MoreScreenStateful();
  }
}
class _MoreScreenStateful extends State<MoreScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text("Profile"),
//        automaticallyImplyLeading: false,
//        backgroundColor: Colors.lightBlueAccent,
//      ),
      body: Body(),
    );
  }
}
