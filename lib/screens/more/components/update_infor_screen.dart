import 'dart:convert';
import 'dart:io';

import 'package:diabetesapp/models/account.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../constants.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = "/update_profile";
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  AccountModel _account;
  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _phone;
  TextEditingController _fullName;
  PickedFile _imageFile;
  final ImagePicker _imagePicker = new ImagePicker();
  @override
  void initState() {
    fetchEvents();
  }

  void fetchEvents() async {
    String url = ip + "/api/getAccount.php";
    var response = await http.post(url, body: {
      'id': '3',
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      AccountModel inforAccount = AccountModel.fromJson(items[0]);
      setState(() {
        _username  = TextEditingController(text: inforAccount.username);
        _fullName  = TextEditingController(text: inforAccount.fullname);
        _email  = TextEditingController(text: inforAccount.email);
        _phone  = TextEditingController(text: inforAccount.phone);
      });
    } else {
      throw Exception('Failed to load data.');
    }
  }
  void updateInfor() async {
    var url = ip + "/api/updateAccount.php";
    final response = await http.post(url, body: {
      "id": "3",
      "fullname": _fullName.text,
      "username": _username.text,
      "email": _email.text,
      "phone": _phone.text,
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
          msg: "Update thông tin thành công",
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
                height: 15,
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: _imageFile == null ? AssetImage("assets/images/s1.png") : FileImage(
                          File(_imageFile.path)),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet())
                              );
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            )
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", _fullName),
              buildTextField("E-mail", _email),
              buildTextField("Username", _username),
              buildTextField("Phone", _phone),
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
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      updateInfor();
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void takePhoto(ImageSource source) async{
    final pickedFile = await _imagePicker.getImage( source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
  Widget bottomSheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Cập nhật hình ảnh của bạn",
            style: TextStyle(
              fontSize: 20
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: (){
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera")
              ),
              FlatButton.icon(
                  onPressed: (){
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.perm_media),
                  label: Text("Thư mục")
              )
            ],
          )
        ],
      ),
    );
  }
  Widget buildTextField(
      String labelText, TextEditingController text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: labelText,
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
