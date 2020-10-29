import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdviceScreen extends StatefulWidget{
  static String routeName = "/advice_screen";
  @override
  _AdviceScreenStateful createState() {
    return _AdviceScreenStateful();
  }
}
class _AdviceScreenStateful extends State<AdviceScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khuyến nghị"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Text('Advice'),
      ),
    );
  }
}
