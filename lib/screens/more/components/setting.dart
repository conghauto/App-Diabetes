import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = "/setting_screen";
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Cài đặt"),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Text(
                "Báo tin khẩn cấp",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                ),
              ),
              title: SizedBox(),
              trailing: Switch(
                activeColor: Colors.redAccent,
                value: UserCurrent.isEmergency,
                onChanged: (value)async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  setState(() {
                    UserCurrent.isEmergency = value;
                    if (UserCurrent.isEmergency == true){
                      prefs.setBool("emergency",true);
                    }else{
                      prefs.setBool("emergency",false);
                    }
                  });
                },
              ),
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

