import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/more/components/daily_steps_page.dart';
import 'package:diabetesapp/screens/more/components/update_infor_screen.dart';
import 'package:diabetesapp/screens/sign_in/sign_in_screen.dart';
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
  String _email = "";

  void initState()  {
     fetchUser();
  }

  void fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');

    String url = ip + "/api/getAccount.php";
    var response = await http.post(url, body: {
      'email': email.toString(),
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      AccountModel inforAccount = AccountModel.fromJson(items[0]);
      await setInfor(inforAccount);
    } else {
      throw Exception('Failed to load data.');
    }
  }
  void setInfor(AccountModel inforAccount){
    setState(() {
      _username  = inforAccount.username;
      _email  = inforAccount.email;
      _avatar = inforAccount.avatar;
    });
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
            title: "Thông tin tài khoản",
            press: () {
              Navigator.pushNamed(context, EditProfilePage.routeName);
            },
          ),
          MenuItem(
            iconSrc: "assets/icons/runner.svg",
            title: "Hoạt động hằng ngày",
            press: () {
              Navigator.pushNamed(context, DailyStepsPage.routeName);
            },
          ),
          MenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Trợ giúp",
            press: () {},
          ),
          MenuItem(
            iconSrc: "assets/icons/exit.svg",
            title: "Đăng xuất",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');

              // Đăng xuất
              facebookLogout();
              googleLogout();

              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
