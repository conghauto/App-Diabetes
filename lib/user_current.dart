import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/account.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCurrent{
  static String email;
  void init(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
  }
  static Future<String> getUserID() async{
    String userID = "";
    String url = ip + "/api/getAccount.php";
    var response = await http.post(url, body: {
      'email': email.toString(),
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      AccountModel inforAccount = AccountModel.fromJson(items[0]);

      userID = inforAccount.id;
    } else {
      throw Exception('Failed to load data.');
    }
    return userID;
  }
}