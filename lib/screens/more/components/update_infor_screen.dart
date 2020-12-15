import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/models/account.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = "/update_profile";
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  AccountModel _account;
  String _imageURL;
  String _avatar;
  TextEditingController _phone;
  TextEditingController _fullName;
  TextEditingController _email;

  PickedFile _imageFile;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = new ImagePicker();

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

    String url = ip + "/api/getAccount.php";
    var response = await http.post(url, body: {
      'id': UserCurrent.userID.toString(),
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      AccountModel inforAccount = AccountModel.fromJson(items[0]);
      setState(() {
        _fullName  = TextEditingController(text: inforAccount.fullname);
        _phone  = TextEditingController(text: inforAccount.phone);
        _email = TextEditingController(text: inforAccount.email);
        _avatar = inforAccount.avatar;
      });
    } else {
      throw Exception('Failed to load data.');
    }
  }
  void updateInfor() async {
    var url = ip + "/api/updateAccount.php";
    final response = await http.post(url, body: {
      "id": UserCurrent.userID.toString(),
      "fullname": _fullName.text,
      "phone": _phone.text,
      "avatar": _avatar
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
      Navigator.pop(context, new AccountModel(fullname: _fullName.text, email: _email.text, avatar: _avatar, phone: _phone.text, id: "1"));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Thông tin tài khoản"),
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
                      backgroundImage: (_avatar == null || _avatar == "null" || _avatar == "") ? AssetImage("assets/images/s1.png") : NetworkImage(
                          _avatar),
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
              Form(key: _formKey, child: Column(
                children: [
                  buildFullNameField(),
                  buildPhoneField(),
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
  void uploadImage() async {
    String id = "3";
    final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: "gs://diabetes-app-1e8a7.appspot.com");
    var file = File(_imageFile.path);
    if (_imageFile != null) {
      var snapshot = await _storage.ref()
          .child('avartar/image'+ DateTime.now().toString())
          .putFile(file);
      var url = await snapshot.ref.getDownloadURL();
      setState(() {
        _avatar = url.toString();
      });
    }
  }
  void takePhoto(ImageSource source) async{
    final pickedFile = await _imagePicker.getImage( source: source);
    setState(() {
      _imageFile = pickedFile;
    });
    uploadImage();
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
  Widget buildFullNameField()
 {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _fullName,
        onSaved: (newValue) => _fullName.text = newValue,
        onChanged: (value) {

        },
        validator: (value){
          value = value.replaceAll(" ", "");
          if (value.isEmpty || value == null){
            addError(error: kFullNameNullError);
            return "";
          }else if (value.length < 5){
            addError(error: kShortFullName);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Họ tên",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
  Widget buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => _phone.text = newValue,
        onChanged: (value) {
          if (value.isNotEmpty || value == null){
            removeError(error: kPhoneNumberNullError);
          }else if (value.length >= 11){
            addError(error: kShortPhoneNumberNullError);
          }
          return null;
        },
        validator: (value){
          if (value.isEmpty || value == null){
            addError(error: kPhoneNumberNullError);
            return "";
          }else if (value.length<10||value.length>=13){
            addError(error: kShortPhoneNumberNullError);
            return "";
          }
          return null;
        },
        controller: _phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Số điện thoại",
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
