import 'package:diabetesapp/screens/advice/food_recommend_screen.dart';
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
class _AdviceScreenStateful extends State<AdviceScreen>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      theme: ThemeData(
//        primaryColor: Colors.blue,
//      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[100],
            bottom: TabBar(
              unselectedLabelColor: Colors.redAccent,
              indicator: BoxDecoration(
//                borderRadius: BorderRadius.circular(50),
                color: Colors.redAccent,
              ),
              tabs: [
                Tab(text: "Thức ăn", icon: Icon(Icons.local_dining_outlined)
                ),
                Tab(text: "Hoạt động", icon: Icon(Icons.directions_run)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(
                            color: Colors.pink[800],// set border color
                            width: 3.0),   // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(30.0)), // set rounded corner radius
                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]// make rounded corner of border
                    ),
                    child: Text("Chế độ dinh dưỡng", style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 17)),
                  ),
                  Expanded(
                    child: FoodRecommendScreen(),
                  ),
                ],
              ),
              Icon(Icons.apps),
            ],
          ),
        ),
      ),
    );
  }
}
