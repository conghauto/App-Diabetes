
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTab extends StatefulWidget {
  @override
  _AddNewTabState createState() {
    return _AddNewTabState();
  }
}

class _AddNewTabState extends State<AddNewTab> {
  TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second screen', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: textFieldController,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),

          RaisedButton(
            child: Text(
              'Lưu',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              _sendDataBack(context);
            },
          )
        ],
      ),
    );
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    Navigator.pop(context, textToSendBack);
  }
}