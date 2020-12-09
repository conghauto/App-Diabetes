import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/account.dart';
import 'package:diabetesapp/models/info-relative.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserCurrent{
  static String userID;
  static String fullName;
  static String emailRelative;
  Future init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID');

    if(userID!=""){
      getName(userID);
      getEmailRelative(userID);
    }

  }
  static Future<String> getUserID(String email) async{
    String userID = "";
    String url = ip + "/api/getEmailAccount.php";
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

  static void getName(String id) async {
    String url = ip + "/api/getAccount.php";
    var response = await http.post(url, body: {
      'id': id,
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      AccountModel inforAccount = AccountModel.fromJson(items[0]);
      fullName = inforAccount.fullname;
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static void getEmailRelative(String id) async {
    String url = ip + "/api/getEmailRelative.php";
    var response = await http.post(url, body: {
      'userID': id,
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      if(items.toString()!="[]") {
        InfoRelativeModel inforAccount = InfoRelativeModel.fromJson(items[0]);
        emailRelative = inforAccount.emailRelative;
      }
    } else {
      throw Exception('Failed to load data.');
    }
  }
}