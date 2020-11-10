import 'package:diabetesapp/constants.dart';
import 'package:flutter/material.dart';

class AddLogSceen extends StatefulWidget {
  static String routeName = "/add_log_screen";
  @override
  _AddLogSceenState createState() => _AddLogSceenState();
}

class _AddLogSceenState extends State<AddLogSceen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
            unselectedLabelColor: Colors.white70,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
            ),
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Đóng',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title:  Text('Thêm thông tin'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Lưu',
                onPressed: () {

                },
              ),
            ],
            backgroundColor: kPrimaryColor,
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
