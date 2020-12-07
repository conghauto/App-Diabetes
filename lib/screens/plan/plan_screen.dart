import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/plan/components/add_event.dart';
import 'package:diabetesapp/screens/plan/components/view_event.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'package:diabetesapp/models/event.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class PlanScreen extends StatefulWidget {
  static String routeName = "/plan_screen";
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  SharedPreferences prefs;
  bool processing;
  DateTime _dateSelected;
  int i = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    _selectedEvents = [];
    processing = true;
  }

  Map<DateTime, List<EventModel>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<EventModel>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventStartDate.year, event.eventStartDate.month,
          event.eventStartDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  List<EventModel> _loadEventOfDate(Map<DateTime, List<EventModel>> data,
      DateTime date) {
    List<EventModel> events = [];
    data.forEach((key, _list) {
      if (key == date) {
        _list.forEach((element) {
          events.add(element);
        });
      }
    });
    return events;
  }

  final String uri = ip + "/api/getNotes.php";

  Future<List<EventModel>> fetchEvents() async {
    String url = ip + "/api/getNotes.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<EventModel> listOfEvents = items.map<EventModel>((json) {
        return EventModel.fromJson(json);
      }).toList();

      return listOfEvents;
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 24.0),
      child: new Scaffold(
        body: FutureBuilder<List<EventModel>>(
            future: fetchEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<EventModel> allEvents = snapshot.data;
                if (allEvents.isNotEmpty) {
                  _events = _groupEvents(allEvents);
                  if (processing) {
                    _dateSelected = convertDateTimeInCurrent();
                  }
                  _selectedEvents = _loadEventOfDate(_events, _dateSelected);
                } else {
                  _events = {};
                  _selectedEvents = [];
                }
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 32.0),
                      child: TableCalendar(
                        events: _events,
                        initialCalendarFormat: CalendarFormat.month,
                        locale: 'vi - Vietnamese',
                        headerVisible: true,
                        calendarStyle: CalendarStyle(
                          canEventMarkersOverflow: true,
                          todayColor: Colors.orange,
                          selectedColor: Colors.red[800],
                          todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonDecoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            formatButtonTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                            formatButtonShowsNext: false,
                            formatButtonVisible: false,
                            titleTextBuilder: (date, locale) =>
                                DateFormat.yMMMM(locale).format(date)
                                    .toString()
                                    .toUpperCase(),
                            titleTextStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        onDaySelected: (day, events, holidays) {
                          setState(() {
                            processing = false;
                            _selectedEvents = events;
                            _dateSelected =
                                DateTime(day.year, day.month, day.day, 12);
                          });
                        },

                        builders: CalendarBuilders(
                          selectedDayBuilder: (context, date, events) =>
                              Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red[400],

                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  date.day.toString(), style: TextStyle(
                                    color: Colors.white),),
                              ),
                          todayDayBuilder: (context, date, events) =>
                              Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  date.day.toString(), style: TextStyle(
                                    color: Colors.white),),
                              ),
                          markersBuilder: (context, date, events, holidays) {
                            final children = <Widget>[];

                            if (events.isNotEmpty) {
                              children.add(
                                Positioned(
                                  right: 1,
                                  bottom: 1,
                                  child: _buildEventsMarker(date, events),
                                ),
                              );
                            }
                            return children;
                          },
                        ),
                        calendarController: _calendarController,),
                    ),
                    ..._selectedEvents.map((event) =>
                        Card(
                          color: Colors.red[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(event.title, style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,)
                              ),
                              subtitle: new Row(children: <Widget>[
                                new Padding(padding: EdgeInsets.fromLTRB(
                                    5, 20, 0, 0)),
                                Container(
                                  height: 10.0,
                                  width: 10.0,
                                  color: Colors.green,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                  ),
                                ),
                                new Padding(padding: EdgeInsets.fromLTRB(
                                    10, 0, 0, 0)),
                                new Text("${FormatDateTime.formatDay(
                                    event.eventEndDate.day)} th ${event
                                    .eventEndDate.month}, ${event
                                    .eventEndDate.year} | ${FormatDateTime
                                    .formatHour(event.eventEndDate
                                    .hour)}:${FormatDateTime.formatMinute(
                                    event.eventEndDate.minute)}"),
                              ]),
//                                trailing: IconButton(
//                                  icon: const Icon(Icons.more_vert_outlined),
//                                  tooltip: 'Xóa',
//                                  onPressed: () {
//                                    setState(() {
//                                      _cancelNotification();
//                                      _showMyDialog(event.id);
//                                    });
//                                  },
//                                ),
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            AddEventScreen(
                                              note: event,
                                            )
                                    )
                                );
                                setState(() {
                                  i++;
                                });
                              },
                              onLongPress: ()async{
                                setState(() {
                                  _showMyDialog(event.id);
                                });
                              },
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              );
            }),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top:20),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              setState(() {
                if(_dateSelected==null){
                  _dateSelected = DateTime.now();
                }
              });
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEventScreen(
                    dateSelected: _dateSelected,
                  )
                  )
              );
              setState(() {
                i = 2;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  deleteItem(String id) async {
    var url = ip + "/api/deleteNote.php";

    final response = await http.post(url, body: {
      "id": id.toString(),
    });

    var data = json.decode(response.body);
    print(data);
    if (data != "Success") {
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
    setState(() {
      i++;
    });
    Navigator.of(context).pop();
//    Navigator.pushNamed(context, PlanScreen.routeName);
  }

  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Widget cancelButton = FlatButton(
          child: Text("Hủy bỏ"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        Widget continueButton = FlatButton(
          child: Text("Tiếp tục"),
          onPressed: () {
            _cancelNotification(id);
            deleteItem(id);
          },
        );

        return AlertDialog(
          title: Text("Thông báo"),
          content: Text("Bạn có muốn xóa mục đã chọn?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );
  }

  static DateTime convertDateTimeInCurrent() {
    DateTime d1 = DateTime.now();
    DateTime d2 = DateTime(
        d1.year, d1.month, d1.day, 12);

    return d2;
  }

  Future<void> _cancelNotification(String idNote) async {
    int id = (idNote==""||idNote=="0")?0:int.parse(idNote);
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}