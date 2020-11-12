import 'package:diabetesapp/components/custom_surffix_icon.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/glucose/log_screens/blood_glucoso_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/carbs_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/exercise_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/medicine_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/weight_screen.dart';
import 'package:diabetesapp/screens/more/components/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddLogSceen extends StatefulWidget {
  static String routeName = "/add_log_screen";
  @override
  _AddLogSceenState createState() => _AddLogSceenState();
}

class _AddLogSceenState extends State<AddLogSceen> with TickerProviderStateMixin{
  Color colorVal = Colors.lightBlue;
  TabController _controller;
  DateTime _time = DateTime.now();
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {
      colorVal = Colors.lightBlue;});
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Đóng',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text("Thêm thông tin"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save_outlined),
                  tooltip: 'Lưu',
                  onPressed: () {

                  },
                ),
              ],
            ),
            body: new ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                new Card(
                  child: new ListTile(
                    leading: const Icon(Icons.timer),
                    title: new TextField(
                      decoration: InputDecoration(hintText: "${FormatDateTime.convertDayOfWeek(_time.weekday)}, ${FormatDateTime.formatDay(_time.day)} th ${_time.month}, ${_time.year}  ${FormatDateTime.formatHour(_time.hour)}:${FormatDateTime.formatMinute(_time.minute)}", enabled: false),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: "Sửa thời gian",
                      onPressed: () async {
                        DateTime picked = await DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
                        }, onConfirm: (date) {
                        }, currentTime: DateTime.now(), locale: LocaleType.vi);
                        if(picked != null) {
                          setState(() {
                            _time = picked;
                          });
                        }
                      },
                    ),
                  ),
                ),
                new Container(
                  width: double.infinity,
                  child: TabBar(
                    indicatorWeight: 4.0,
                    indicatorColor:Color(0xff3f51b5),
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    controller: _controller,
                    tabs: [
                      new Tab(
                        icon: Icon(Icons.opacity,
                        color: _controller.index == 0 ? colorVal : Colors.grey),
                        child: Text('Đường huyết', style: TextStyle( color: _controller.index == 0
                            ?  Colors.lightBlue : Colors.grey)),
                      ),
                      new Tab(
                        icon: Icon(FontAwesomeIcons.pills,
                            color: _controller.index == 1 ? colorVal : Colors.grey),
                        child: Text('Thuốc', style: TextStyle( color: _controller.index == 1
                            ?  Colors.lightBlue : Colors.grey)),
                      ),
                      new Tab(
                        icon: Icon(FontAwesomeIcons.weight,
                            color: _controller.index == 2 ? colorVal : Colors.grey),
                        child: Text('Cân nặng', style: TextStyle( color: _controller.index == 2
                            ?  Colors.lightBlue : Colors.grey)),
                      ),
                      new Tab(
                        icon: Icon(Icons.fastfood,
                            color: _controller.index == 3 ? colorVal : Colors.grey),
                        child: Text('Thức ăn', style: TextStyle( color: _controller.index == 3
                            ?  Colors.lightBlue : Colors.grey)),
                      ),
                      new Tab(
                        icon: Icon(Icons.directions_run,
                            color: _controller.index == 4 ? colorVal : Colors.grey),
                        child: Text('Hoạt động', style: TextStyle( color: _controller.index == 4
                            ?  Colors.lightBlue : Colors.grey)),
                      ),
                    ],

                  ),
                ),

                new Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 20),
                  height: 400,
                  child: new TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      BloodGlucosoLog(),
                      MedicineLog(),
                      WeightLog(),
                      CarbsLog(),
                      ExerciseLog()
                    ],
                  ),
                ),
              ],
            ),
          )
      )
    );
  }
}