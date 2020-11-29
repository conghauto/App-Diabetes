import 'package:flutter/material.dart';
import 'package:diabetesapp/size_config.dart';

//const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryColor = Color(0xFF271ca1);
const kPrimaryLightColor = Color(0xFFFFECDF);
//const kPrimaryGradientColor = LinearGradient(
//  begin: Alignment.topLeft,
//  end: Alignment.bottomRight,
//  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
//);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kTextLigntColor = Color(0xFF7286A5);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Bạn chưa nhập địa chỉ email";
const String kHeightNullError = "Bạn chưa nhập chiều cao";
const String kWeightNullError = "Bạn chưa nhập cân nặng";
const String kInvalidEmailError = "Email không hợp lệ";
const String kPassNullError = "Bạn chưa nhập mật khẩu";
const String kShortPassError = "Mật khẩu phải có ít 8 ký tự";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Bạn chưa nhập số điện thoại";
const String kAddressNullError = "Please Enter your address";
const String kFullNameNullError = "Bạn chưa nhập họ tên";
const String kShortFullName = "Họ tên không hợp lệ";
const String kShortPhoneNumberNullError = "Số điện thoại không hợp lệ";
const String kUsernameNullError = "Bạn chưa điền tên đăng nhập";
const String kIndexGlycemicNullError = "Bạn chưa nhập chỉ số đường huyết";
const String kShortUsername = "Tên đăng nhập không hợp lệ";
const String ip = "http://192.168.1.4:8080";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
