import 'package:diabetesapp/screens/plan/components/add_event.dart';
import 'package:flutter/material.dart';
import 'package:diabetesapp/models/event.dart';

import 'package:diabetesapp/extensions/format_datetime.dart';

class EventDetailsPage extends StatefulWidget {
  final EventModel event;
  static String routeName = "/detail_event";

  const EventDetailsPage({Key key, @required this.event}) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  int i=0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          color: Colors.black,
        ),
        title: Text('Chi tiết', style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Chỉnh sửa',
            onPressed: () async {
              await  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          AddEventScreen(
                            note: widget.event,
                          )
                  ),
              );
              setState(() {
                i++;
              });
            },
          ),
          ),
        ],
        backgroundColor: Colors.pink[50],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0,24.0,8.0,8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
              Card(
                color: Colors.black26,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                borderOnForeground: true,
                elevation: 0,

                  child: ListTile(
                    title: Text('Tiêu đề',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text(widget.event.title, style: TextStyle(fontSize: 16),),
                    leading: Icon(
                      Icons.subtitles_outlined,
                      color: Colors.blue[500],
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightGreen,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  borderOnForeground: true,
                  elevation: 0,

                  child: ListTile(
                    title: Text('Nội dung',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text(widget.event.description, style: TextStyle(fontSize: 16),),
                    leading: Icon(
                      Icons.data_usage_outlined,
                      color: Colors.blue[500],
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("Từ:   ${FormatDateTime.convertDayOfWeek(widget.event.eventStartDate.weekday)}, ${FormatDateTime.formatDay(widget.event.eventStartDate.day)} th ${widget.event.eventStartDate.month}, ${widget.event.eventStartDate.year}  ${FormatDateTime.formatHour(widget.event.eventStartDate.hour)}:${FormatDateTime.formatMinute(widget.event.eventStartDate.minute)}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.calendar_view_day_outlined,
                    color: Colors.blue[500],
                  ),
                ),
                ListTile(
                  title: Text("Đến: ${FormatDateTime.convertDayOfWeek(widget.event.eventEndDate.weekday)}, ${FormatDateTime.formatDay(widget.event.eventEndDate.day)} th ${widget.event.eventEndDate.month}, ${widget.event.eventEndDate.year}  ${FormatDateTime.formatHour(widget.event.eventEndDate.hour)}:${FormatDateTime.formatMinute(widget.event.eventEndDate.minute)}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.schedule_outlined,
                    color: Colors.blue[500],
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}