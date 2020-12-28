import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:diabetesapp/models/event.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart';

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}
class AddEventScreen extends StatefulWidget {
  static String routeName = "/add_event";
  final EventModel note;
  final DateTime dateSelected;

  AddEventScreen({Key key, this.note, this.dateSelected}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController _title;
  TextEditingController _description;
  DateTime _eventStartDate;
  DateTime _eventEndDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;
  int id = 0;
  bool _isListening = false;
  bool _isListening2 = false;
  SpeechToText _speech = SpeechToText();
  SpeechToText _speech2 = SpeechToText();
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == "notListening") {
            setState(() => _isListening = false);
            _speech.stop();
          }
        },
        onError: (val) {
            Fluttertoast.showToast(
              msg: "Đã xáy ra lỗi. Thử lại",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
            );
            setState(() => _isListening = false);
            _speech.stop();
        },
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _description.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  void _listen2() async {
    if (!_isListening2) {
      bool available = await _speech2.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == "notListening") {
            setState(() => _isListening2 = false);
            _speech2.stop();
          }
        },
        onError: (val) {
          Fluttertoast.showToast(
              msg: "Đã xáy ra lỗi",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          setState(() => _isListening2 = false);
          _speech2.stop();
        },
      );
      if (available) {
        setState(() => _isListening2 = true);
        _speech2.listen(
          onResult: (val) => setState(() {
            _title.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening2 = false);
      _speech2.stop();
    }
  }
  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(text:  widget.note != null ? widget.note.description : "");

    if(widget.note !=null){
      _eventStartDate = widget.note.eventStartDate;
      _eventEndDate = widget.note.eventEndDate;
    }else{
      _eventStartDate = widget.dateSelected;
      _eventEndDate = DateTime.now().add(new Duration(days: 1));
    }

    processing = false;
  }

  void dispose() {
    _title.dispose();
    _description.dispose();
    _speech.cancel();
    _speech2.cancel();
    super.dispose();
  }

  void sendData() async {
    var url = ip + "/api/addNote.php";
    final response = await http.post(url, body: {
      "title": _title.text,
      "description": _description.text,
      "eventStartDate": _eventStartDate.toString(),
      "eventEndDate": _eventEndDate.toString(),
      'userID': UserCurrent.userID.toString(),
    });

    var data = (json.decode(response.body)).toString();


    if(data=="Fail"){
      Fluttertoast.showToast(
          msg: "Đã xáy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else {
      id = int.parse((json.decode(response.body)).toString());
      UserCurrent.showNotificationCustomSound(_eventStartDate,_eventEndDate,id,_title.text.toString(),_description.text.toString());
      Fluttertoast.showToast(
          msg: "Tạo lịch nhắc thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Thay đổi" : "Thêm nhắc nhở",
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0XFF444974)),
        ),
        backgroundColor: Colors.black12,
        automaticallyImplyLeading: true,
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20.0),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextFormField(
                    controller: _title,
                    validator: (value) =>
                    (value.isEmpty) ? "Nhập tên tiêu đề" : null,
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Tiêu đề",
                      filled: true,
                      fillColor: Colors.white,
//                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: (_isListening2) ? Icon(Icons.mic, color: Colors.red) : Icon(Icons.mic_none, color: Colors.black),
                  onPressed: () {
                    _listen2();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: TextFormField(
                    controller: _description,
                    minLines: 3,
                    maxLines: 5,
                    validator: (value) =>
                    (value.isEmpty) ? "Nhập nội dung ghi chú" : null,
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
                    decoration: InputDecoration(
                        labelText: "Nội dung",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                  trailing: IconButton(
                    icon: (_isListening) ? Icon(Icons.mic, color: Colors.red) : Icon(Icons.mic_none, color: Colors.black),
                    onPressed: () {
                      _listen();
                    },
                  ),
                )
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Thời gian bắt đầu"),
                subtitle: Text(
                    "${FormatDateTime.convertDayOfWeek(_eventStartDate.weekday)}, ${FormatDateTime.formatDay(_eventStartDate.day)} th ${_eventStartDate.month}, ${_eventStartDate.year}  ${FormatDateTime.formatHour(_eventStartDate.hour)}:${FormatDateTime.formatMinute(_eventStartDate.minute)}",
                    style: TextStyle(color: Colors.blue[800])),
                trailing: Icon(Icons.calendar_today_sharp),
                onTap: ()async{
                  await DatePicker.showDateTimePicker(context,
                      minTime: DateTime(2000,1,1),
                      maxTime: DateTime(2050,1,1),
                      showTitleActions: true, onChanged: (date) {
//                    print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        if (date.isAfter(_eventEndDate)) {
                          Fluttertoast.showToast(
                              msg: "Ngày bắt đầu không phù hợp",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        } else {
                          setState(() {
                            _eventStartDate = date;
                          });
                        }
                      }, currentTime: DateTime.now(), locale: LocaleType.vi);
//                  DateTime picked = await showDatePicker(context: context, initialDate: _eventStartDate, firstDate: DateTime(_eventStartDate.year-5), lastDate: DateTime(_eventStartDate.year+5));
                },
              ),

              ListTile(
                title: Text("Thời gian kết thúc", style: TextStyle(color: Colors.black),),
                subtitle: Text(
                    "${FormatDateTime.convertDayOfWeek(_eventEndDate.weekday)}, ${FormatDateTime.formatDay(_eventEndDate.day)} th ${_eventEndDate.month}, ${_eventEndDate.year}  ${FormatDateTime.formatHour(_eventEndDate.hour)}:${FormatDateTime.formatMinute(_eventEndDate.minute)}",
                    style: TextStyle(color: Colors.blue[800])),
                trailing: Icon(Icons.calendar_today),
                onTap: ()async{
                  await DatePicker.showDateTimePicker(context,
                      minTime: DateTime(2000,1,1),
                      maxTime: DateTime(2050,1,1),
                      showTitleActions: true, onChanged: (date) {
                      }, onConfirm: (date) {
                        if (date.isBefore(_eventStartDate)) {
                          Fluttertoast.showToast(
                              msg: "Ngày kết thúc không phù hợp",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }  else {
                          setState(() {
                            _eventEndDate = date;
                          });
                        }
                      }, currentTime: DateTime.now(), locale: LocaleType.vi);
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
                          updateData(widget.note.id.toString());
                          setState(() {
                            Navigator.pop(context);
                          });
                        } else {
                          await sendData();

                          setState(() {
                            Navigator.pop(context);
                          });
                        }

                        setState(() {
                          processing = false;
                        });
//                        Navigator.pushNamed(context,PlanScreen.routeName);
                      }
                    },
                    child: Text(widget.note != null ? "Cập nhật" : "Lưu",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 18,
                          fontWeight: FontWeight.bold, color: Colors.white),
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

  void updateData(String id) async{
    var url = ip +"/api/updateNote.php";

    final response = await http.post(url, body: {
      "id": id.toString(),
      "title": _title.text,
      "description": _description.text,
      "eventStartDate": _eventStartDate.toString(),
      "eventEndDate": _eventEndDate.toString(),
    });

    var data = json.decode(response.body);
    print(data);

    if (data=="Success"){
      int i = int.parse(id);
      int difference =  _eventEndDate.difference(_eventStartDate).inDays;
      for(int i=0;i<difference;i++){
        await UserCurrent.cancelNotification(i);
      }

      UserCurrent.showNotificationCustomSound(_eventStartDate,_eventEndDate,i,_title.text.toString(),_description.text.toString());
      Fluttertoast.showToast(
          msg: "Cập nhật thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[800],
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      Fluttertoast.showToast(
          msg: "Đã xáy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}