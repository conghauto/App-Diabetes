import 'package:diabetesapp/components/no_account_text.dart';
import 'package:diabetesapp/components/sign_in_facebook.dart';
import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/components/socal_card.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/sign_in/components/sign_in_form.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Đăng Nhập",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
//                Text(
//                  "Đăng nhập bằng email và mật khẩu  \nhoặc sử dụng mạng xã hội",
//                  textAlign: TextAlign.center,
//                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignInForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInGoogle(),
                    SignInFacebook()
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
