import 'package:diabetesapp/components/custom_surffix_icon.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/glucose/glucose_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/blood_glucoso_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/carbs_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/exercise_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/medicine_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/weight_screen.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/more/components/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddLogSceen extends StatefulWidget {
  static String routeName = "/add_log_screen";
  static DateTime time;
//
//  GlobalKey<AppKeysState> key = GlobalKey<AppKeysState>();

  @override
  _AddLogSceenState createState() => _AddLogSceenState();
}

class _AddLogSceenState extends State<AddLogSceen> with TickerProviderStateMixin{
  Color colorVal = Colors.lightBlue;
  TabController _controller;
  int countAddLog = 0;
//  GlobalKey<AppKeysState> key = new GlobalKey<AppKeysState>();

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 5, vsync: this);
    AddLogSceen.time = DateTime.now();
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
                  icon: Icon(
                    Icons.save_outlined,
                    semanticLabel: countAddLog.toString(),
                  ),
                  tooltip: 'Lưu',
                  onPressed: () async {
                      if(GlobalKeys.key1.currentState!=null){
                        if(GlobalKeys.key1.currentState.isValid){
                          GlobalKeys.key1.currentState.addGlycemic();
                        }
                      }
                      if(GlobalKeys.key2.currentState!=null){
                          if(GlobalKeys.key2.currentState.isValid)
                          {
                            GlobalKeys.key2.currentState.addWeight();
                            //Navigator.pop(context);
                          }
                      }
                      if(GlobalKeys.key3.currentState!=null){
                        if(GlobalKeys.key3.currentState.isValidTime&&
                            GlobalKeys.key3.currentState.isValidType)
                        {
                          GlobalKeys.key3.currentState.addActivity();
                        }
                      }
					            if(GlobalKeys.keyCarbs.currentState!=null){
                        if(GlobalKeys.keyCarbs.currentState.isValid)
                        {
                          GlobalKeys.keyCarbs.currentState.addCarb();
                          //Navigator.pop(context);
                        }
                      }
                      if(GlobalKeys.keyMedicine.currentState!=null){
                        if(GlobalKeys.keyMedicine.currentState.isValid)
                        {
                          GlobalKeys.keyMedicine.currentState.addMedicine();
//                          Navigator.pop(context);
                        }
                      }

                      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
                      decoration: InputDecoration(hintText: "${FormatDateTime.convertDayOfWeek(AddLogSceen.time.weekday)}, ${FormatDateTime.formatDay(AddLogSceen.time.day)} th ${AddLogSceen.time.month}, ${AddLogSceen.time.year}  ${FormatDateTime.formatHour(AddLogSceen.time.hour)}:${FormatDateTime.formatMinute(AddLogSceen.time.minute)}", enabled: false),
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
                            AddLogSceen.time = picked;
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
                  height: 500,
                  child: new TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      BloodGlucosoLog(key:GlobalKeys.key1),
                      MedicineLog(key: GlobalKeys.keyMedicine),
                      WeightLog(key:GlobalKeys.key2),
                      CarbsLog(key: GlobalKeys.keyCarbs),
                      ExerciseLog(key:GlobalKeys.key3)
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

class GlobalKeys {
  static GlobalKey<BloodGlucosoLogState> key1 = GlobalKey<BloodGlucosoLogState>();
  static GlobalKey<WeightLogState> key2 = GlobalKey<WeightLogState>();
  static GlobalKey<MedicineLogState> keyMedicine = GlobalKey<MedicineLogState>();
  static GlobalKey<ExerciseLogState> key3 = GlobalKey<ExerciseLogState>();
  static GlobalKey<CarbsLogState> keyCarbs = GlobalKey<CarbsLogState>();
}





