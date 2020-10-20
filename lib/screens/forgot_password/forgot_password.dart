import 'package:diabetesapp/screens/forgot_password/components/body.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text("Quên mật khẩu"),
      ),
      body: Body(),
    );
  }
}
