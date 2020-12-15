import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import '../../../constants.dart';

class UpdatePassword extends StatefulWidget {
  static String routeName = "/update_password_screen";
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool isSecureOldPassword = true;
  bool isSecureNewPassword = true;
  bool isSecureConfirmPassword = true;
  TextEditingController _oldPassword;
  TextEditingController _newPassword;
  TextEditingController _confirmPassword;

  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

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
    _oldPassword  = TextEditingController(text: "");
    _newPassword  = TextEditingController(text: "");
    _confirmPassword = TextEditingController(text: "");
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
  void addError({String error}){
    if(!errors.contains(error))
      setState(() {
        errors.add((error));
      });
  }

  void removeError({String error}){
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  void updatePassword() async {
    var url = ip + "/api/updatePassword.php";
    final response = await http.post(url, body: {
      "id": UserCurrent.userID.toString(),
      "password": _oldPassword.text,
      "newpassword": _newPassword.text
    });

    var data = json.decode(response.body);
    if(data == "Error Password"){
      Fluttertoast.showToast(
          msg: "Mật khẩu cũ không chính xác",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Thay đổi mật khẩu thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);
    } else if (data == "Error"){
      Fluttertoast.showToast(
          msg: "Đã có lỗi xảy ra",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Cập nhật mật khẩu"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Form(key: _formKey, child: Column(
                children: [
                  buildOldPasswordField(),
                  buildNewPasswordField(),
                  buildConfirmPasswordField(),
                  FormError(errors: errors),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Hủy",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (_confirmPassword.text != _newPassword.text){
                              Fluttertoast.showToast(
                                  msg: "Mật khẩu xác thực không đúng",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            } else {
                              updatePassword();
                            }
                          }
                        },
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Lưu",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              )
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildOldPasswordField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        obscureText: isSecureOldPassword,
        keyboardType: TextInputType.text,
        controller: _oldPassword,
        onChanged: (value) {

        },
        validator: (value){
          value = value.replaceAll(" ", "");
          if (value.isEmpty || value == null){
            addError(error: "Mật khẩu cũ không hợp lệ");
            return "";
          }else if (value.length < 8){
            addError(error: "Mật khẩu cũ không hợp lệ");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Mật khẩu cũ",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: (){
              setState(() {
                isSecureOldPassword = !isSecureOldPassword;
              });
            },
          ),
        ),
      ),
    );
  }
  Widget buildNewPasswordField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        obscureText: isSecureNewPassword,
        keyboardType: TextInputType.text,
        controller: _newPassword,
        onChanged: (value) {

        },
        validator: (value){
          value = value.replaceAll(" ", "");
          if (value.isEmpty || value == null){
            addError(error: "Mật khẩu mới không hợp lệ");
            return "";
          }else if (value.length < 8){
            addError(error: "Mật khẩu mới không an toàn");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3, left: 15),
          labelText: "Mật khẩu mới",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: (){
              setState(() {
                isSecureNewPassword = !isSecureNewPassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildConfirmPasswordField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        obscureText: isSecureConfirmPassword,
        keyboardType: TextInputType.text,
        controller: _confirmPassword,
        onChanged: (value) {

        },
        validator: (value){
          value = value.replaceAll(" ", "");
          if (value.isEmpty || value == null){
            addError(error: "Mật khẩu xác thực không hợp lệ");
            return "";
          }else if (value.length < 8){
            addError(error: "Mật khẩu xác thực không an toàn");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3, left: 15),
          labelText: "Xác nhận mật khẩu mới",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: (){
              setState(() {
                isSecureConfirmPassword = !isSecureConfirmPassword;
              });
            },
          ),
        ),
      ),
    );
  }

}
