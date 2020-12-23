import 'dart:convert';

import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/info_personal/info_person_sreeen.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:diabetesapp/widgets/ProgressDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import '../constants.dart';
import '../size_config.dart';
class SignInFacebook extends StatefulWidget{
  static final facebookLogin = FacebookLogin();
  static bool isLoggedIn = false;
  @override
  _SignInFacebookState createState() {
    return _SignInFacebookState();
  }
}
class _SignInFacebookState extends State<SignInFacebook>{
  Map userProfile;

  _loginWithFB() async{
    SignInFacebook.facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await SignInFacebook.facebookLogin.logIn(['email']);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Đang xử lý'),
    );

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);

        this.setState(() {
          userProfile = profile;
          SignInFacebook.isLoggedIn = true;
        });
        saveInfoUser(profile['name'], profile['email'], "");
        break;

      case FacebookLoginStatus.cancelledByUser:
        this.setState(() {
          SignInFacebook.isLoggedIn = false;
        });
        break;
      case FacebookLoginStatus.error:
        this.setState(() {
          SignInFacebook.isLoggedIn = false;
        });
        break;
    }
  }

  String password = "apaaja";
  saveInfoUser(String username, String email, String phoneNumber) async {
    var url = ip + "/api/register.php";

    var response = await http.post(url, body: {
      "fullname": username,
      "email": email,
      "phone": phoneNumber,
      "password": password,
    });

    var data = json.decode(response.body);

    if(data=="Success"){
      // Lưu trạng thái đăng nhậpuserID
      String userID = await UserCurrent.getUserID(email);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCurrent.userID = userID;
      if(prefs.getString('userID')!=null){
        prefs.remove('userID');
        prefs.remove('query');
      }

      prefs.setString('userID', userID);
      Fluttertoast.showToast(
          msg: "Đăng nhập thành công",
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushNamed(context, InfoPersonScreen.routeName);
    }
    else if(data=="Exist"){
      Fluttertoast.showToast(
          msg: "Đăng nhập thành công",
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // Lưu trạng thái đăng nhập
      final String userID = await UserCurrent.getUserID(email);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getString('userID')!=null){
        prefs.remove('userID');
        prefs.remove('query');
      }
      prefs.setString('userID', userID);

      await UserCurrent().init();
      if(UserCurrent.emailRelative==null){
        Navigator.pushNamed(context, InfoPersonScreen.routeName);
      }else{
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    }
    else {
      Fluttertoast.showToast(
          msg: "Email đã tồn tại",
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _loginWithFB,
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(60),
        width: getProportionateScreenWidth(60),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset("assets/icons/facebook-2.svg"),
      ),
    );
  }
}

Future<void> facebookLogout(){
  if(SignInFacebook.isLoggedIn) {
    SignInFacebook.facebookLogin.logOut();
  }
}