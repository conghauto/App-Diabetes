import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget{
  static String routeName = "/plan_screen";
  @override
  _PlanScreenStateful createState() {
    return _PlanScreenStateful();
  }
}
class _PlanScreenStateful extends State<PlanScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lập lịch"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Text('Plan'),
      ),
    );
  }
}
