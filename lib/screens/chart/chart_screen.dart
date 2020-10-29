import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  _ChartScreenStateful createState() {
    return _ChartScreenStateful();
  }
}
class _ChartScreenStateful extends State<ChartScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biểu đồ"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Text('Chart'),
      ),
    );
  }
}
