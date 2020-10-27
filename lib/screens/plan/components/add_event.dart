import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/event.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddEventScreen extends StatefulWidget {
  static String routeName = "/add_event";
  final EventModel note;

  const AddEventScreen({Key key, this.note}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextStyle style = TextStyle(fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  DateTime _eventStartDate;
  DateTime _eventEndDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(text:  widget.note != null ? widget.note.description : "");
    _eventStartDate = DateTime.now();
    _eventEndDate = DateTime.now();
    processing = false;
  }


  void sendData() async {
    var url = ip + "/api/addNote.php";
    final response = await http.post(url, body: {
      "title": _title.text,
      "description": _description.text,
      "eventStartDate": _eventStartDate.toString(),
      "eventEndDate": _eventEndDate.toString(),
    });

    var data = json.decode(response.body);
    print(data);
    if(data=="Fail"){
      Fluttertoast.showToast(
          msg: "Email đã tồn tại",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Note" : "Add note"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) =>
                  (value.isEmpty) ? "Nhập tên tiêu đề" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Tiêu đề",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Nhập nội dung ghi chú" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Nội dung",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Thời gian bắt đầu"),
                subtitle: Text("${_eventStartDate.year} - ${_eventStartDate.month} - ${_eventStartDate.day}"),
                onTap: ()async{
                  DateTime picked = await showDatePicker(context: context, initialDate: _eventStartDate, firstDate: DateTime(_eventStartDate.year-5), lastDate: DateTime(_eventStartDate.year+5));
                  if(picked != null) {
                    setState(() {
                      _eventStartDate = picked;
                    });
                  }
                },
              ),

              ListTile(
                title: Text("Thời gian kết thúc"),
                subtitle: Text("${_eventEndDate.year} - ${_eventEndDate.month} - ${_eventEndDate.day}"),
                onTap: ()async{
                  DateTime picked = await showDatePicker(context: context, initialDate: _eventEndDate, firstDate: DateTime(_eventEndDate.year-5), lastDate: DateTime(_eventEndDate.year+5));
                  if(picked != null) {
                    setState(() {
                      _eventEndDate = picked;
                    });
                  }
                },
              ),

              SizedBox(height: 10.0),
              if (processing) Center(child: CircularProgressIndicator()) else Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          processing = true;
                        });
                        if (widget.note != null) {
//                          await eventDBS.updateData(widget.note.id, data);
                        } else {
                           sendData();
                        }
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                    },
                    child: Text(
                      "Lưu",
                      style: style.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}