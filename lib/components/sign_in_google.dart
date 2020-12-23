import 'dart:convert';

import 'package:diabetesapp/screens/info_personal/info_person_sreeen.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:diabetesapp/widgets/ProgressDialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../screens/home/home_screen.dart';
import '../size_config.dart';

class SignInGoogle extends StatefulWidget {
  static String routeName = "/sign_in_google";
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static bool isLoggedIn = false;

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleSignIn() async {
    await Firebase.initializeApp();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Đang xử lý'),
    );

    final GoogleSignInAccount googleSignInAccount = await SignInGoogle.googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);


      SignInGoogle.isLoggedIn=true;

      var phone=user.phoneNumber==null?"":user.phoneNumber;
      saveInfoUser(user.displayName,user.email,phone);

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
      onTap: _handleSignIn,
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
        child: SvgPicture.asset("assets/icons/google-icon.svg"),
      ),
    );
  }
}

Future<void> googleLogout(){
  if(SignInGoogle.isLoggedIn) {
    SignInGoogle.googleSignIn.signOut();
  }
}