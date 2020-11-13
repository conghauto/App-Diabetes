import 'dart:convert';
import 'dart:io';

import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/models/account.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _phone;
  TextEditingController _fullName;

  PickedFile _imageFile;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = new ImagePicker();
  String _userID="";

  @override
  void initState() {
    fetchUser();
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
        _userID = inforAccount.id;
        _username  = TextEditingController(text: inforAccount.username);
        _fullName  = TextEditingController(text: inforAccount.fullname);
        _email  = TextEditingController(text: inforAccount.email);
        _phone  = TextEditingController(text: inforAccount.phone);
        _avatar = inforAccount.avatar;
      });
    } else {
      throw Exception('Failed to load data.');
    }
  }
  void updateInfor() async {
    var url = ip + "/api/updateAccount.php";
    final response = await http.post(url, body: {
      "id": _userID,
      "fullname": _fullName.text,
      "username": _username.text,
      "email": _email.text,
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
                    avatarImage,
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
                  buildEmailField(),
                  buildUsernameField(),
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
                        child: Text("CANCEL",
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
          if (value.isNotEmpty || value == null){
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
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Full Name",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
  Widget buildEmailField()
 {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => _email.text = newValue,
        onChanged: (value) {
          if (value.isNotEmpty || value == null){
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
        controller: _email,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "E-mail",
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
            labelText: "Phone",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
  Widget buildUsernameField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => _username.text = newValue,
        onChanged: (value) {
          if (value.isNotEmpty || value == null ){
            removeError(error: kUsernameNullError);
          }else if (value.length >= 5){
            addError(error: kShortUsername);
          }
          return null;
        },
        validator: (value){
          if (value.isEmpty || value == null){
            addError(error: kFullNameNullError);
            return "";
          }else if (value.length < 5){
            addError(error: kShortFullName);
            return "";
          }
          return null;
        },
        controller: _username,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3, left: 15),
            labelText: "Username",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget get avatarImage {
    return _avatar.toString().split(",").contains("assets")?
    CircleAvatar(
      radius: 80,
      backgroundImage: AssetImage("assets/images/s1.png")):
    CircleAvatar(
      radius: 80,
      backgroundImage:NetworkImage(_avatar),
    );
  }
}
