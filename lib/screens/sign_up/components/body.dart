import 'package:diabetesapp/components/account_text.dart';
import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/components/socal_card.dart';
import 'package:diabetesapp/screens/sign_up/components/sign_up_form.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
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
                  "Đăng ký tài khoản",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Hoàn thành thông tin \n hoặc sử dụng mạng xã hội đăng ký",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInGoogle(),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                AccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
