import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/sign_in/components/body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text("Đăng nhập"),
      backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Body(),
    );
  }
}
