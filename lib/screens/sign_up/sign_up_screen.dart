import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/sign_up/components/body.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text("Đăng ký"),
      backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
