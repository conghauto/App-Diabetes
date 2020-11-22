import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogCard extends StatelessWidget {
  const LogCard({
    Key key,
    this.iconSrc,
    this.title,
    this.nameMedicine,
    this.unit,
    this.indexValue,
    this.time,
    this.press,
    this.longPress,
    this.colorPrimary,
  }) : super(key: key);
  final String iconSrc, title, nameMedicine, unit, indexValue;
  final DateTime time;
  final Function press, longPress;
  final Color colorPrimary;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.red[50],
        child: ListTile(
            title: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        new Text("${FormatDateTime.formatDay(time.day)} th ${time.month}, ${time.year}",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(iconSrc),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0,left: 25.0),
                                        child: Text(title,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            color: colorPrimary,
                                            fontSize: 17,
                                          )),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:25.0, top:3.0),
                                    child: Text(nameMedicine,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14,
                                        )
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(indexValue,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(unit,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text("${FormatDateTime.formatHour(time.hour)}:${FormatDateTime.formatMinute(time.minute)}",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black45,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
              ],
              )
            ),
            onTap: press,
            onLongPress: longPress,
          ),
    );
  }
}
