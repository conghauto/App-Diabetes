import 'dart:convert';

import 'package:diabetesapp/components/custom_surffix_icon.dart';
import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/account.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/widgets/ProgressDialog.dart';
import 'package:diabetesapp/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InfoPersonScreen extends StatefulWidget {
  static String routeName = "/info_person_screen";
  @override
  _InfoPersonScreenState createState() => _InfoPersonScreenState();
}

class _InfoPersonScreenState extends State<InfoPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  int _gender = 1;
  int _type = 2;
  String _idUser = "";

  String height;
  String weight;

  final List<String> errors = [];
  DateTime selectedDate = DateTime(1950,1,1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchIDUser();
  }

  void fetchIDUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');

    String url = ip + "/api/getAccount.php";
    var response = await http.post(url, body: {
      'email': email.toString(),
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      AccountModel inforAccount = AccountModel.fromJson(items[0]);
      setState(() {
        _idUser  = inforAccount.id;
      });
    } else {
      throw Exception('Failed to load data.');
    }
  }

  void setValueGender(int value) {
    setState(() {
      _gender = value;
    });
  }

  void setTypeDiabetes(int value) {
    setState(() {
      _type = value;
    });
  }

  void sendInforUser()async{
    var url = ip + "/api/registerInfoUser.php";
    var response = await http.post(url, body: {
      'birthday': selectedDate.toString(),
      'gender': _gender.toString(),
      'height': height,
      'weight': weight,
      'typeDiabete': _type.toString(),
      'userID': _idUser,
    });

    Navigator.pop(context);
    var data = json.decode(response.body);
    if(data=="Fail"){
      Fluttertoast.showToast(
          msg: "Đã xảy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      Navigator.pushNamed(context, HomeScreen.routeName);
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
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                color: Colors.white70,
                image: new DecorationImage(image: new AssetImage("assets/images/3unsplash.jpg"),
                  fit: BoxFit.cover,),
              ),
            ),
            SizedBox(
              width: double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.screenHeight * 0.08),
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
                                    DateFormat("dd/MM/yyyy").format(selectedDate),
                                    style: TextStyle(color: Colors.blue[800],
                                    fontFamily: 'Roboto',
                                    fontSize: 16)
                                ),
                              ),
                              trailing: Icon(Icons.calendar_today),
                              onTap: ()async{
                                final DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050),
                                  initialEntryMode: DatePickerEntryMode.input,
                                  helpText: 'NGÀY SINH', // Can be used as title
                                  cancelText: 'Hủy bỏ',
                                  confirmText: 'Chọn',
                                  errorFormatText: 'Nhập ngày hợp lệ',
                                  errorInvalidText: 'Ngày không hợp lệ',
                                  fieldLabelText: 'Nhập ngày',
                                  fieldHintText: 'dd/mm/yyyy',
                                );
                                if (picked != null && picked != selectedDate)
                                  setState(() {
                                    selectedDate = picked;
                                  });
                              },
                            ),
                          ),
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
                                          onChanged: setValueGender,
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
                                          onChanged: setValueGender,
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
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Card(
                            child: Column(
                                children: [
                                  new ListTile(
                                    title: Text( 'Chiều cao(cm)',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    subtitle: buildHeightFormField(),
                                  ),
                                ],
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Card(
                            child: Column(
                              children: [
                                new ListTile(
                                  title: Text( 'Cân nặng(kg)',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  subtitle: buildWeightFormField(),
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
                                          groupValue: _type,
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
                                          groupValue: _type,
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
                          SizedBox(height: getProportionateScreenHeight(10)),
                          FormError(errors: errors),
                          SizedBox(height: getProportionateScreenHeight(25)),
                          DefaultButton(
                            text: "Tiếp tục",
                            press:  () async{
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                sendInforUser();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

            ),
          ],
        )
    );
  }

  TextFormField buildHeightFormField(){
    return TextFormField(
      style: new TextStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
      ),
      keyboardType: TextInputType.numberWithOptions(),
      onSaved: (newValue) => height = newValue,
      onChanged: (value) {
        if (value.isNotEmpty){
          removeError(error: kHeightNullError);
        }
        return null;
      },
      validator: (value){
        if (value.isEmpty){
          addError(error: kHeightNullError);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        hintText: "Nhập chiều cao của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
  TextFormField buildWeightFormField(){
    return TextFormField(
      style: new TextStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
      ),
      keyboardType: TextInputType.numberWithOptions(),
      onSaved: (newValue) => weight = newValue,
      onChanged: (value) {
        if (value.isNotEmpty){
          removeError(error: kWeightNullError);
        }
        return null;
      },
      validator: (value){
        if (value.isEmpty){
          addError(error: kWeightNullError);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        hintText: "Nhập cân nặng của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}