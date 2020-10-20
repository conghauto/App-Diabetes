import 'dart:convert';

import 'package:diabetesapp/components/custom_surffix_icon.dart';
import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/screens/forgot_password/forgot_password.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/widgets/ProgressDialog.dart';
import 'package:diabetesapp/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  final List<String> errors = [];

  void login()async {

    // show please wait dialog

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Bạn đang đăng nhập',),
    );

    var url = ip + "/api/login.php";
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    Navigator.pop(context);
    var data = json.decode(response.body);
    if(data=="Success"){
      Fluttertoast.showToast(
          msg: "Đăng nhập thành công",
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushNamed(context,HomeScreen.routeName);
    }else{
      Fluttertoast.showToast(
          msg: "Email hoặc mật khẩu chưa chính xác",
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, ForgetPassword.routeName),
                child: Text(
                  "Quên mật khẩu",
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),

              ),
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(25)),
          DefaultButton(
            text: "Đăng nhập",
            press:  () async{
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                login();
//                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Nhập mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty){
          removeError(error: kEmailNullError);
        }else if (emailValidatorRegExp.hasMatch(value)){
          addError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value){
        if (value.isEmpty){
          addError(error: kEmailNullError);
          return "";
        }else if (!emailValidatorRegExp.hasMatch(value)){
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        labelText: "Email",
        hintText: "Nhập email của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}


