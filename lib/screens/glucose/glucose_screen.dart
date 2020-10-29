import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlucoseScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  _GlucoseScreenStateful createState() {
    return _GlucoseScreenStateful();
  }
}
class _GlucoseScreenStateful extends State<GlucoseScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Glucose"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Text('Glucose'),
      ),
    );
  }
}
