import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:diabetesapp/components/no_account_text.dart';
import 'package:diabetesapp/components/sign_in_facebook.dart';
import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/components/socal_card.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/sign_in/components/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../size_config.dart';
class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ProgressDialog progressDialog;
  bool isConnected = true;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    progressDialog.style(message: "Kiểm tra kết nối Internet");
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
      setState(() {
        isConnected = true;
      });
      checkInternet();
    } else {
      setState(() {
        isConnected = false;
      });
      checkInternet();
    }
  }
  void checkInternet(){
    if (isConnected) {
      progressDialog.hide();
    } else {
      progressDialog.show();
    }
  }
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
