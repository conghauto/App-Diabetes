import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/glucose/add_log_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlucoseScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  _GlucoseScreenStateful createState() {
    return _GlucoseScreenStateful();
  }
}
class _GlucoseScreenStateful extends State<GlucoseScreen>{
  final europeanCountries = ['Albania', 'Andorra', 'Armenia', 'Austria',
    'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria',
    'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland',
    'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
    'Italy', 'Kazakhstan', 'Kosovo', 'Latvia', 'Liechtenstein', 'Lithuania',
    'Luxembourg', 'Macedonia', 'Malta', 'Moldova', 'Monaco', 'Montenegro',
    'Netherlands', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia',
    'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
    'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican City'];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea (
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child: new Container(
                height: 220,
                color: Colors.white,
                child: new Stack(
                  children: <Widget>[
                    Container(
                      height: 200,
                      color: kPrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Row(
                          children: <Widget>[
                            new Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: new Container(
                                  height: 200.0,
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    color: kPrimaryColor,
                                  ),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.opacity,
                                              color: Colors.red,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:5),
                                              child: new Text("BG", style: new TextStyle(color: Colors.white,
                                                  fontSize: 12, fontWeight: FontWeight.bold)
                                              ),
                                            )
                                          ]
                                      ),
                                      SizedBox(height: 15.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("avg  -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      ),
                                      SizedBox(height: 5.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("max -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      ),
                                      SizedBox(height: 5.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("min  -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: new Container(
                                  height: 200.0,
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    color: kPrimaryColor,
                                  ),
                                  child: new Column(
//                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top:5.0),
                                              child: new SvgPicture.asset("assets/icons/pill.svg"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:5, top:7),
                                              child: new Text("Thuốc",style: new TextStyle(color: Colors.white,
                                                  fontSize: 12, fontWeight: FontWeight.bold)
                                              ),
                                            )
                                          ]
                                      ),
                                      SizedBox(height: 20.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("bol -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      ),
                                      SizedBox(height: 5.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("bas -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: new Container(
                                  height: 200.0,
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    color: kPrimaryColor,
                                  ),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.local_dining_outlined,
                                              color: Colors.orange,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:5),
                                              child: new Text("Thức ăn",
                                                  style: new TextStyle(color: Colors.white,
                                                      fontSize: 12, fontWeight: FontWeight.bold)
                                              ),
                                            )
                                          ]
                                      ),
                                      SizedBox(height: 15.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("carbs -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      ),
                                      SizedBox(height: 5.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("cal -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: new Container(
                                  height: 200.0,
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    color: kPrimaryColor,
                                  ),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.directions_run,
                                              color: Colors.greenAccent,
                                            ),
                                            Expanded(
                                                child: Text("Hoạt động",
                                                    style: new TextStyle(color: Colors.white,
                                                        fontSize: 12, fontWeight: FontWeight.bold)
                                                )
                                            )
                                          ]
                                      ),
                                      SizedBox(height: 15.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("số bước   -",
                                                style: new TextStyle(color: Colors.blueGrey,
                                                    fontSize: 12))
                                          ]
                                      ),
                                      SizedBox(height: 5.0),
                                      Row(
                                          children: <Widget>[
                                            new Text("thời gian  -",
                                                style: new TextStyle(color: Colors.blueGrey, fontSize: 12)
                                            )
                                          ]
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 170,
                      left: (SizeConfig.screenWidth/2-60),
                      child: Center(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(40.0,5.0, 40.0, 7.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            Navigator.pushNamed(context, AddLogSceen.routeName);
                          },
                          child: Text(
                            "Thêm",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 FlatButton(
                   onPressed: () => {},
                   color: Colors.white,
                   padding: EdgeInsets.all(10.0),
                   child: Row(
                     children: [
                       Text("Hiển thị", style: TextStyle(
                         fontFamily: 'Roboto',
                         fontSize: 15,
                         color: Colors.black,
                        ),
                       ),
                       Icon(Icons.arrow_drop_down),
                     ],
                   ),
                 )
               ],
            ),
            SizedBox(height:10.0),
            new Expanded(child:
            ListView.builder(
                itemCount: europeanCountries.length,
                itemBuilder: (context, index) {
              return Card(
                  color: Colors.red[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(europeanCountries[index], style: TextStyle(
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
                      onTap: () async {

                      },
                    ),
                  )
              );
            }))
          ],
        ),
      ),
    );
  }

  Widget itemsListDisplay(BuildContext context){
    final europeanCountries = ['Albania', 'Andorra', 'Armenia', 'Austria',
      'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria',
      'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland',
      'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
      'Italy', 'Kazakhstan', 'Kosovo', 'Latvia', 'Liechtenstein', 'Lithuania',
      'Luxembourg', 'Macedonia', 'Malta', 'Moldova', 'Monaco', 'Montenegro',
      'Netherlands', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia',
      'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
      'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican City'];

    return ListView.builder(
      itemCount: europeanCountries.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(europeanCountries[index]),
          ),
        );
      },
    );
  }
}


