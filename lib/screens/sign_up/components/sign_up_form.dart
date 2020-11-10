import 'dart:convert';

import 'package:diabetesapp/components/custom_surffix_icon.dart';
import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/widgets/ProgressDialog.dart';
import 'package:diabetesapp/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String fullName;
  String username="";
  String email;
  String phone;
  String password;
  final List<String> errors = [];

  void registerUser()async{

    // show please wait dialog

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Đang xử lý',),
    );

    var url = ip + "/api/register.php";
    var response = await http.post(url, body: {
      'fullname': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    });

    Navigator.pop(context);
    var data = json.decode(response.body);
    if(data=="Error"){
      Fluttertoast.showToast(
          msg: "Email đã tồn tại",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Navigator.pushNamed(context, HomeScreen.routeName);
      Fluttertoast.showToast(
          msg: "Đăng ký thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
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
          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(25)),
          DefaultButton(
            text: "Đăng ký",
            press:  () async{
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                registerUser();
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
        labelText: "Mật khẩu",
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

  TextFormField buildFullNameFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => fullName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty){
          removeError(error: kFullNameNullError);
        }else if (value.length >= 5){
          addError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value){
        if (value.isEmpty){
          addError(error: kFullNameNullError);
          return "";
        }else if (value.length < 5){
          addError(error: kShortFullName);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        labelText: "Họ tên",
        hintText: "Nhập họ tên của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField(){
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty){
          removeError(error: kPhoneNumberNullError);
        }else if (value.length >= 11){
          addError(error: kShortPhoneNumberNullError);
        }
        return null;
      },
      validator: (value){
        if (value.isEmpty){
          addError(error: kPhoneNumberNullError);
          return "";
        }else if (value.length<10||value.length>=13){
          addError(error: kShortPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Nhập số điện thoại của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );

  }
}