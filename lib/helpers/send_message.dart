import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../constants.dart';
import 'package:diabetesapp/user_current.dart';
import 'dart:convert';
import 'package:diabetesapp/models/info-user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SendMessageState {

  String _id = "";
  String _fulname = "";
  String _phoneRelative= "";


  Future<void> getInfoUser() async {
    String url = ip + "/api/getInfoUser.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      InfoUserModel infoUser = InfoUserModel.fromJson(items[0]);
      _id = infoUser.id;
      _fulname = infoUser.fullname;
      _phoneRelative = infoUser.phoneRelative;

    } else {
      throw Exception('Failed to load data.');
    }
  }

  void _sendSMS(String phoneRelative) async {
    try {
      String _result = await sendSMS(
          message: "aaaaa", recipients: phoneRelative);
    } catch (error) {
       _message = error.toString();
    }
  }

//  void _canSendSMS() async {
//    bool _result = await canSendSMS();
//    _canSendSMSMessage = _result ? 'This unit can send SMS' : 'This unit cannot send SMS';
//  }


  void _send() async{
    await getInfoUser();
    if (_phoneRelative == null) {
      Fluttertoast.showToast(
          msg: "Đã xáy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _sendSMS(_phoneRelative);
    }
  }

}
