import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/more/components/update_infor_screen.dart';
import 'package:diabetesapp/screens/more/components/update_password_screen.dart';
import 'package:diabetesapp/screens/more/components/update_personal_infor.dart';
import 'package:diabetesapp/screens/sign_in/sign_in_screen.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../size_config.dart';
import 'package:diabetesapp/components/sign_in_facebook.dart';
import 'package:diabetesapp/components/sign_in_google.dart';
import 'infor.dart';
import 'menu_item.dart';
import 'package:diabetesapp/models/account.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _avatar = "";
  String _username = "";
  String _email= "";
  void initState()  {
     fetchUser();
  }

  void fetchUser() async {

    String url = ip + "/api/getAccount.php";
    var response = await http.post(url, body: {
      'id': UserCurrent.userID.toString(),
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      AccountModel inforAccount = AccountModel.fromJson(items[0]);
      setState(() {
        _username  = inforAccount.fullname;
        _email  = inforAccount.email;
        _avatar = inforAccount.avatar;
      });
    } else {
      throw Exception('Failed to load data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Info(
            image: _avatar,
            name: _username,
            email: _email,
          ),
          SizedBox(height: SizeConfig.defaultSize * 2), //20
          MenuItem(
            iconSrc: "assets/icons/user.svg",
            title: "Tài khoản của bạn",
            press: () async {
              AccountModel result = await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EditProfilePage()
              ));
              if (result != null) {
                setState(() {
                  this._avatar = result.avatar;
                  this._email = result.email;
                  this._username = result.fullname;
                });
              }
            },
          ),
          MenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Thông tin cá nhân",
            press: () async{
              AccountModel result = await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EditPersonalInfo()
              ));
            },
          ),
          MenuItem(
            iconSrc: "assets/icons/Lock.svg",
            title: "Thay đổi mật khẩu",
            press: () async {
              await Navigator.pushNamed(context, UpdatePassword.routeName);
            },
          ),
          MenuItem(
            iconSrc: "assets/icons/exit.svg",
            title: "Đăng xuất",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('userID');
              prefs.remove('query');

              // Đăng xuất
              facebookLogout();
              googleLogout();

              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
