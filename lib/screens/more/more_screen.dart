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
      appBar: AppBar(
        title: Text("Chức năng"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('More Screen'),
      ),
    );
  }
}
