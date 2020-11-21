import 'dart:convert';

import 'package:diabetesapp/components/log_card.dart';
import 'package:diabetesapp/components/select_filter.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/activity.dart';
import 'package:diabetesapp/models/carb.dart';
import 'package:diabetesapp/models/glycemic.dart';
import 'package:diabetesapp/models/medicine.dart';
import 'package:diabetesapp/models/weight.dart';
import 'package:diabetesapp/screens/glucose/add_log_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GlucoseScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  GlucoseScreenState createState() {
    return GlucoseScreenState();
  }
}
class GlucoseScreenState extends State<GlucoseScreen>{
  List<dynamic> listItems=new List<dynamic>();
  List<GlycemicModel> listGlycemics=new List<GlycemicModel>();
  List<CarbModel> listCarbs=new List<CarbModel>();
  List<MedicineModel> listMedicine=new List<MedicineModel>();
  List<ActivityModel> listActivities=new List<ActivityModel>();
  List<WeightModel> listWeights=new List<WeightModel>();
  List<String>query;

  @override
  void initState() {
    setState(() {
      sortItems();
    });
//    fetchGlycemics();
//    fetchActivities();
//    fetchCarbs();
//    fetchMedicine();
//    fetchWeights();
  }


  void sortItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    query = prefs.getStringList('query');

    await fetchGlycemics();
    await fetchActivities();
    await fetchCarbs();
    await fetchMedicine();
    await fetchWeights();

    setState(() {

      if(query!=null){
        if(query[0]=="allDate"||query[1]==""){
          if(query[4]=="0"){
            listGlycemics.forEach((element) {
              listItems.add(element);
            });
            listCarbs.forEach((element) {
              listItems.add(element);
            });
            listCarbs.forEach((element) {
              listItems.add(element);
            });
            listWeights.forEach((element) {
              listItems.add(element);
            });
            listActivities.forEach((element) {
              listItems.add(element);
            });

            listItems.sort((b,a) => a.measureTime.compareTo(b.measureTime));
          }
          if(query[5]=="1"){
            listGlycemics.forEach((element) {
              listItems.add(element);
            });
          }

          if(query[6]=="2"){
            listCarbs.forEach((element) {
              listItems.add(element);
            });
          }

          if(query[7]=="3"){
            listMedicine.forEach((element) {
              listItems.add(element);
            });
          }

          if(query[8]=="4"){
            listWeights.forEach((element) {
              listItems.add(element);
            });
          }

          if(query[9]=="5"){
            listActivities.forEach((element) {
              listItems.add(element);
            });
          }
        }
        else if(query[0]==""&&query[1]=="customDate"&&query[2]!=""&&query[3]!=""){
          DateTime startDate=DateTime.parse(query[2]);
          DateTime endDate=DateTime.parse(query[3]);

          if(query[4]=="0"){
            listGlycemics.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
              listItems.add(element);
            });
            listCarbs.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                listItems.add(element);
            });
            listMedicine.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                listItems.add(element);
            });
            listWeights.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                listItems.add(element);
            });
            listActivities.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                listItems.add(element);
            });

            listItems.sort((b,a) => a.measureTime.compareTo(b.measureTime));
          }
          else {
            if (query[5] == "1") {
              listGlycemics.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                  listItems.add(element);
              });
            }

            if (query[6] == "2") {
              listCarbs.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                  listItems.add(element);
              });
            }

            if (query[7] == "3") {
              listMedicine.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                  listItems.add(element);
              });
            }

            if (query[8] == "4") {
              listWeights.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                  listItems.add(element);
              });
            }

            if (query[9] == "5") {
              listActivities.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                  listItems.add(element);
              });
            }

            listItems.sort((b,a) => a.measureTime.compareTo(b.measureTime));
          }
        }
      }
      else{
        listGlycemics.forEach((element) {
          listItems.add(element);
        });
        listCarbs.forEach((element) {
          listItems.add(element);
        });
        listCarbs.forEach((element) {
          listItems.add(element);
        });
        listWeights.forEach((element) {
          listItems.add(element);
        });
        listActivities.forEach((element) {
          listItems.add(element);
        });

        listItems.sort((b,a) => a.measureTime.compareTo(b.measureTime));

      }
    });
  }

  Future<void> fetchGlycemics() async {
    String url = ip + "/api/getGlycemics.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<GlycemicModel> list= items.map<GlycemicModel>((json) {
        return GlycemicModel.fromJson(json);
      }).toList();

      if(list!=null){
        list.sort((b, a) => a.measureTime.compareTo(b.measureTime));
        setState(() {
          list.forEach((element) => listGlycemics.add(element));
        });
      }

    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchWeights() async {
    String url = ip + "/api/getWeights.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      listWeights = items.map<WeightModel>((json) {
        return WeightModel.fromJson(json);
      }).toList();

//      if(listWeights!=null){
//        listWeights.sort((b, a) => a.measureTime.compareTo(b.measureTime));
//      }
      setState(() {
        listWeights.sort((b, a) => a.measureTime.compareTo(b.measureTime));
      });

//      setState(() {
//        list.forEach((element) => listWeights.add(element));
//      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchActivities() async {
    String url = ip + "/api/getActivities.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      listActivities= items.map<ActivityModel>((json) {
        return ActivityModel.fromJson(json);
      }).toList();

//      if(list!=null){
//        listActivities.sort((b, a) => a.activityTime.compareTo(b.activityTime));
//      }

      setState(() {
        listActivities.sort((b, a) => a.measureTime.compareTo(b.measureTime));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchCarbs() async {
    String url = ip + "/api/getCarbs.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      listCarbs = items.map<CarbModel>((json) {
        return CarbModel.fromJson(json);
      }).toList();

//      if(listCarbs!=null){
//        listCarbs.sort((b, a) => a.measureTime.compareTo(b.measureTime));
//      }
      setState(() {
        listCarbs.sort((b, a) => a.measureTime.compareTo(b.measureTime));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchMedicine() async {
    String url = ip + "/api/getMedicine.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      listMedicine = items.map<MedicineModel>((json) {
        return MedicineModel.fromJson(json);
      }).toList();

      setState(() {
        listMedicine.sort((b, a) => a.measureTime.compareTo(b.measureTime));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

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
                   onPressed: () async => {
                     await Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (_) =>
                            SelectFilter()))
                   },
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
            new Expanded(child:
            ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  if ((listItems[index].idModel=="1")) {
                    return LogCard(
                      iconSrc: "assets/icons/glucose.svg",
                      title: "Đường huyết",
                      nameMedicine: "",
                      unit: "ml/dl",
                      indexValue: listItems[index].indexG,
                      time: listItems[index].measureTime,
                      press: (){

                      },
                      colorPrimary: Colors.red,
                    );
                  }
                  else if(listItems[index].idModel=="2"){
                    return LogCard(
                      iconSrc: "assets/icons/pill-2.svg",
                      title: "Thuốc",
                      nameMedicine: listItems[index].name,
                      unit: listItems[index].unit,
                      indexValue: listItems[index].amount,
                      time: listItems[index].measureTime,
                      press: (){

                      },
                      colorPrimary: Colors.teal,
                    );
                  }
                  else if(listItems[index].idModel=="3"){
                    return LogCard(
                      iconSrc: "assets/icons/weight.svg",
                      title: "Cân nặng",
                      nameMedicine: "",
                      unit: "kg",
                      indexValue: listItems[index].weight,
                      time: listItems[index].measureTime,
                      press: (){
                      },
                      colorPrimary: Colors.grey,
                    );
                  }
                  else if(listItems[index].idModel=="4"){
                    return LogCard(
                      iconSrc: "assets/icons/food.svg",
                      title: "Thức ăn",
                      nameMedicine: "Carbs "+listItems[index].carb+" gam",
                      unit: "",
                      indexValue: "",
                      time: listItems[index].measureTime,
                      press: (){

                      },
                      colorPrimary: Colors.orange,
                    );
                  }
                  else{
                    return LogCard(
                      iconSrc: "assets/icons/run.svg",
                      title: "Hoạt động",
                      nameMedicine: listItems[index].nameActivity,
                      unit: "phút",
                      indexValue: listItems[index].timeActivity,
                      time: listItems[index].measureTime,
                      press: (){

                      },
                      colorPrimary: Colors.green,
                    );
                  }
            }))
          ],
        ),
      ),
    );
  }
}


