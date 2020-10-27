import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/plan/components/add_event.dart';
import 'package:diabetesapp/screens/plan/components/view_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

import 'package:diabetesapp/models/event.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    _selectedEvents = [];
//    initPrefs();
  }

//  initPrefs() async {
//    prefs = await SharedPreferences.getInstance();
//    setState(() {
//      _events = Map<DateTime, List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events")?? "{}")));
//    });
//  }

//  Map<String, dynamic> encodeMap(Map<DateTime,dynamic> map){
//    Map<String,dynamic> newMap = {};
//    map.forEach((key, value) {
//      newMap[key.toString()] = map[key];
//    });
//    return newMap;
//  }
//
//  Map<DateTime, dynamic> decodeMap(Map<String,dynamic> map){
//    Map<DateTime,dynamic> newMap = {};
//    map.forEach((key, value) {
//      newMap[DateTime.parse(key)] = map[key];
//    });
//    return newMap;
//  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventStartDate.year, event.eventStartDate.month, event.eventStartDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  final String uri = ip + "/api/getNotes.php";

  Future<List<EventModel>> fetchEvents() async {
    var response = await http.get(uri);

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
    return new Scaffold(
     body: FutureBuilder<List<EventModel>>(
         future: fetchEvents(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             List<EventModel> allEvents = snapshot.data;
             if (allEvents.isNotEmpty) {
               _events = _groupEvents(allEvents);
             } else {
               _events = {};
               _selectedEvents = [];
             }
           }
           return SingleChildScrollView(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 TableCalendar(
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
//                  holidayStyle: TextStyle().copyWith(color: Colors.red[800]),
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
                       _selectedEvents = events;
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
                           child: Text(date.day.toString(), style: TextStyle(
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
                           child: Text(date.day.toString(), style: TextStyle(
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

                       if (holidays.isNotEmpty) {
                         children.add(
                           Positioned(
                             right: -2,
                             top: -2,
                             child: _buildHolidaysMarker(),
                           ),
                         );
                       }

                       return children;
                     },
                   ),
                   calendarController: _calendarController,),
                 ..._selectedEvents.map((event) =>
                     Card(
                         child: ListTile(
                           title: Text(event.title, style: TextStyle(),),
                           onTap: () {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (_) =>
                                         EventDetailsPage(
                                           event: event,
                                         )
                                 )
                             );
                           },
                         )
                     )
                 ),
               ],
             ),
           );
         }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,64),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, AddEventScreen.routeName),
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

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

//  _showAddDialog() {
//    showDialog(
//        context: context,
//        builder: (context) => AlertDialog(
//          content: TextField(
//            controller: _eventController,
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text("Save"),
//              onPressed: (){
//                if(_eventController.text.isEmpty) return;
//                setState(() {
//                  if(_events[_calendarController.selectedDay]!=null){
//                    _events[_calendarController.selectedDay].add(_eventController.text);
//                  }else{
//                    _events[_calendarController.selectedDay] = [_eventController.text];
//                  }
//                  prefs.setString("events",json.encode(encodeMap(_events)));
//                  _eventController.clear();
//                  Navigator.pop(context);
//                });
//              },
//            ),
//          ],
//        )
//    );
//  }
}
