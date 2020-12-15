import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/models/info-user.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';

class EditPersonalInfo extends StatefulWidget {
  static String routeName = "/update_personal_info";
  @override
  _EditPersonalInfoState createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  DateTime birthday = DateTime.now();
  int _gender;
  TextEditingController _height;
  TextEditingController _weight;
  int _typeDiabete;
  TextEditingController _emailRelative;
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
    fetchUser();
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

  void setTypeDiabetes(int value) {
    setState(() {
      _typeDiabete = value;
    });
  }
  void setValueGender(int value) {
    setState(() {
      _gender = value;
    });
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
  void fetchUser() async {

    String url = ip + "/api/getInfoUser.php";
    var response = await http.post(url, body: {
      'userID': UserCurrent.userID.toString(),
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      InfoUserModel inforAccount = InfoUserModel.fromJson(items[0]);
      await setInfor(inforAccount);
    } else {
      throw Exception('Failed to load data.');
    }
  }
  void setInfor(InfoUserModel inforAccount){
    setState(() {
      birthday = inforAccount.birthday;
      _gender = int.tryParse(inforAccount.gender);
      _height = TextEditingController(text: inforAccount.height);
      _weight = TextEditingController(text: inforAccount.weight);
      _typeDiabete = int.tryParse(inforAccount.typeDiabete);
      _emailRelative = TextEditingController(text: inforAccount.emailRelative);
    });
  }
  void updateInfor() async {
    var url = ip + "/api/updatePersonalInfo.php";
    final response = await http.post(url, body: {
      "userID": UserCurrent.userID.toString(),
      "birthday": birthday.toString(),
      "gender": _gender.toString(),
      "height": _height.text,
      "weight": _weight.text,
      "typeDiabete": _typeDiabete.toString(),
      "emailRelative": _emailRelative.text
    });

    var data = json.decode(response.body);
    print(data);
    if(data != "Success"){
      Fluttertoast.showToast(
          msg: "Đã xáy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Cập nhật thông tin thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Thông tin của bạn"),
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
                height: 35,
              ),
              Form(key: _formKey, child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text("Ngày sinh",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text(
                            DateFormat("dd/MM/yyyy").format(birthday),
                            style: TextStyle(color: Colors.blue[800],
                                fontFamily: 'Roboto',
                                fontSize: 16)
                        ),
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: ()async{
                        await DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1950,1,1),
                            maxTime: DateTime(2050,1,1),
                            locale: LocaleType.vi,
                            currentTime: birthday,
                            onChanged: (date){

                            },
                            onConfirm: (date) {
                              if (date.isAfter(DateTime.now())){
                                Fluttertoast.showToast(
                                    msg: "Ngày không hợp lệ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              } else {
                                setState(() {
                                  birthday = date;
                                });
                              }
                            }
                        );
                      },
                    ),
                  ),
                  buildHeightFormField(),
                  buildWeightFormField(),
                  buildEmailFormField(),
                  Card(
                    child: Column(
                      children: [
                        new ListTile(
                          title: Text( 'Giới tính',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left:0),
                            child: Row(
                              children: <Widget>[
                                new Radio(
                                  value: 1,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Nam',
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto'
                                  ),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Nữ',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        new ListTile(
                          title: Text( 'Tiểu đường',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left:0),
                            child: Row(
                              children: <Widget>[
                                new Radio(
                                  value: 1,
                                  groupValue: _typeDiabete,
                                  onChanged: setTypeDiabetes,
                                ),
                                new Text(
                                  'Loại 1',
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto'
                                  ),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: _typeDiabete,
                                  onChanged: setTypeDiabetes,
                                ),
                                new Text(
                                  'Loại 2',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            updateInfor();
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
  Widget buildHeightFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        style: new TextStyle(
          fontSize: 16.0,
          fontFamily: 'Roboto',
        ),
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (value) {
          if (value.isNotEmpty){
            removeError(error: kHeightNullError);
          }
          return null;
        },
        validator: (value){
          try {
            double result = double.tryParse(value);
            if (result <= 0){
              addError(error: kHeightNullError);
              return "";
            } else {
              return null;
            }
          } catch (ex){
            addError(error: kHeightNullError);
            return "";
          }
        },
        controller: _height,
        decoration:  InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Chiều cao (cm)",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
  Widget buildWeightFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        style: new TextStyle(
          fontSize: 16.0,
          fontFamily: 'Roboto',
        ),
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (value) {
          if (value.isNotEmpty){
            removeError(error: kWeightNullError);
          }
          return null;
        },
        validator: (value){
          try {
            double result = double.tryParse(value);
            if (result <= 0){
              addError(error: kWeightNullError);
              return "";
            } else {
              return null;
            }
          } catch (ex){
            addError(error: kWeightNullError);
            return "";
          }
        },
        controller: _weight,
        decoration:  InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Cân nặng (kg)",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      )
    );
  }
  Widget buildEmailFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
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
        controller: _emailRelative,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Email người thân",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
