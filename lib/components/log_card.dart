import 'package:flutter/material.dart';

class LogCard extends StatelessWidget {
  const LogCard({
    Key key,
    this.iconSrc,
    this.title,
    this.unit,
    this.indexValue,
    this.time,
    this.press
  }) : super(key: key);
  final String iconSrc, title, unit, indexValue;
  final DateTime time;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.red[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(title, style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20,)
            ),
            subtitle: new Row(children: <Widget>[
              new Padding(padding: EdgeInsets.fromLTRB(5, 20, 0, 0)),
              Container(
                height: 10.0,
                width: 10.0,
                color: Colors.green,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                ),
              ),
              new Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
//                        new Text("${FormatDateTime.formatDay(event.eventStartDate.day)} th ${event.eventStartDate.month}, ${event.eventStartDate.year} | ${FormatDateTime.formatHour(event.eventStartDate.hour)}:${FormatDateTime.formatMinute(event.eventStartDate.minute)}"),
            ]),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              tooltip: 'Xóa',
              onPressed: (){

                },
            ),
            onTap: press,
          ),
        )
    );
  }
}
