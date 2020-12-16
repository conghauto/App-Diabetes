import 'package:diabetesapp/screens/advice/recommend_screens/activity_screen.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/food_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdviceScreen extends StatefulWidget{
  static String routeName = "/advice_screen";
  @override
  _AdviceScreenStateful createState() {
    return _AdviceScreenStateful();
  }
}

class _AdviceScreenStateful extends State<AdviceScreen>with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    _controller = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25),
        TabBar(
          controller: _controller,
          unselectedLabelColor: Colors.blueAccent,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.redAccent,
          ),
          tabs: [
            Tab(text: "Thức ăn", icon: Icon(Icons.local_dining_outlined)),
            Tab(text: "Hoạt động", icon: Icon(Icons.directions_run)),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              FoodScreen(),
              ActivityScreen(),
            ],
          ),
        )
      ],
    );
  }
}
