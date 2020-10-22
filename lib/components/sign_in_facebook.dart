import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import '../size_config.dart';
class SignInFacebook extends StatefulWidget{

  @override
  _SignInFacebookState createState() {
    return _SignInFacebookState();
  }
}
class _SignInFacebookState extends State<SignInFacebook>{
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async{
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        this.setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        Navigator.pushNamed(context, HomeScreen.routeName);
        break;

      case FacebookLoginStatus.cancelledByUser:
        this.setState(() {
          _isLoggedIn = false;
        });
        break;
      case FacebookLoginStatus.error:
        this.setState(() {
          _isLoggedIn = false;
        });
        break;
    }

  }

  _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
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