import 'dart:convert';

import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/advice/advice_screen.dart';
import 'package:diabetesapp/screens/chart/chart_screen.dart';
import 'package:diabetesapp/screens/glucose/glucose_screen.dart';
import 'package:diabetesapp/screens/more/more_screen.dart';
import 'package:diabetesapp/screens/plan/plan_screen.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shake/shake.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenStateful createState() {
    return _HomeScreenStateful();
  }
}
class _HomeScreenStateful extends State<HomeScreen> {
  ShakeDetector detector;
  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [GlucoseScreen(), ChartScreen(), PlanScreen(), AdviceScreen(), MoreScreen()];
  void _onPageChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: (){
        if(UserCurrent.isEmergency == true){
          UserCurrent.showNotificationEmergency();
          sendEmail();
        }
      },
    );
  }

  void sendEmail()async{
    var url = ip + "/api/sendEmailEmergency.php";
    var response = await http.post(url, body: {
      'userID': UserCurrent.userID.toString(),
      'fullname': UserCurrent.fullName.toString(),
      'emailRelative': UserCurrent.emailRelative.toString(),
    });
  }

  @override
  void dispose() {
    detector.stopListening();

    super.dispose();
  }

  void _onItemTape(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }
  @override
  Widget build(BuildContext context) {
//    SizeConfig().init(context);
//    UserCurrent().init(context);
    return Scaffold(
      body: PageView(
       controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
       children: _screens,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTape,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.opacity),
            title: Text('Glucose'),
            backgroundColor: Colors.lightBlueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined),
              title: Text('Biểu đồ'),
              backgroundColor: Colors.lightBlueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              title: Text('Lập lịch'),
              backgroundColor: Colors.lightBlueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              title: Text('Gợi ý'),
              backgroundColor: Colors.lightBlueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day_rounded),
              title: Text('Thêm'),
              backgroundColor: Colors.lightBlueAccent
          ),
        ],
      ),
    );
  }
}
