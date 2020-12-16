
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        title: Text('Thêm thẻ mới', style: TextStyle(color: Colors.white),),
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
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3, left: 15),
                  labelText: "Tên thẻ",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
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
    String textCheck = textToSendBack.trim();
    textCheck = textCheck.replaceAll(" ", "");
    if (textCheck.isEmpty || textCheck.length <= 0){
      Fluttertoast.showToast(
          msg: "Vui lòng nhập giá trị",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Navigator.pop(context, textToSendBack);
    }

  }
}