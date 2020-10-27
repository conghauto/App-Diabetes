import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/chart/chart_screen.dart';
import 'package:diabetesapp/screens/glucose/glucose_screen.dart';
import 'package:diabetesapp/screens/more_info/more_info_screen.dart';
import 'package:diabetesapp/screens/plan/plan_screen.dart';
import 'package:diabetesapp/screens/recommendation/recommendation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 11, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    GlucoseScreen(),
    ChartScreen(),
    PlanScreen(),
    RecommendationSreen(),
    MoreInfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: bottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
//      decoration: BoxDecoration(
//        color: Colors.amber,
//        borderRadius: BorderRadius.only(
//            topLeft: Radius.circular(200), topRight: Radius.circular(200)),
//      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,

        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/diabetes.svg",
                height: 22),
            title: new Text("Đường huyết", style: optionStyle),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/bar_chart.svg",
                height: 22),
            title: new Text("Biểu đồ", style: optionStyle),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/planner.svg",
              height: 22,),
            title: new Text("Lập lịch", style: optionStyle),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/trust.svg",
                height: 22),
            title: new Text("Khuyến nghị", style: optionStyle),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/menu.svg",
                height: 22),
            title: new Text("Thêm", style: optionStyle),
          ),
        ],
      ),
    );
  }
}

