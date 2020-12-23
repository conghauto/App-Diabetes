import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/account.dart';
import 'package:diabetesapp/models/info-relative.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UserCurrent{
  static String userID;
  static String fullName;
  static String emailRelative;
  static bool isEmergency = false;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Future init() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID');
    bool check = prefs.getBool('emergency') ==true?true:false;
    if(check){
      isEmergency = prefs.getBool('emergency');
    }

    if(userID!="") {
      await getName(userID);
      await getEmailRelative(userID);
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

  static Future<void> getName(String id) async {
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

  static Future<void> getEmailRelative(String id) async {
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

  static Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
      icon: 'info',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('warning'),
      color: Colors.yellowAccent,
      largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'blood_glucose',
    );
  }

  static Future<void> showNotificationCustomSound(DateTime startDate,DateTime endDate,
      int id, String title, String body) async {
    int difference = startDate.isAfter(DateTime.now())?endDate.difference(startDate).inDays+1:endDate.difference(startDate).inDays;
    for(int i=0;i<difference;i++){
      var time = Time(startDate.hour,startDate.minute,0);
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        icon: 'info',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('warning'),
        color: Colors.yellowAccent,
        largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
      );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          id,
          title,
          body,
          time,
          platformChannelSpecifics,
          payload: 'note'
      );
    }
  }

  static Future<void> showNotificationEmergency() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
      icon: 'alarm',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('warning'),
      color: Colors.redAccent,
      largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      "Khẩn cấp",
      "Thông tin đã được báo cho người thân.",
      platformChannelSpecifics,
      payload: 'blood_glucose',
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelNotification1(String idNote) async {
    int id = (idNote==""||idNote=="0")?0:int.parse(idNote);
    await flutterLocalNotificationsPlugin.cancel(id);
  }

}