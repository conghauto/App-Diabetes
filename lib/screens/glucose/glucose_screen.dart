import 'dart:convert';

import 'package:diabetesapp/components/log_card.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/activity.dart';
import 'package:diabetesapp/models/carb.dart';
import 'package:diabetesapp/models/glycemic.dart';
import 'package:diabetesapp/models/medicine.dart';
import 'package:diabetesapp/models/weight.dart';
import 'package:diabetesapp/screens/glucose/add_log_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_blood_glucoso.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_carbs.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_medicine.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'log_screens/update_exercise.dart';
import 'log_screens/update_weight.dart';

class GlucoseScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  _GlucoseScreenStateful createState() {
    return _GlucoseScreenStateful();
  }
}
class _GlucoseScreenStateful extends State<GlucoseScreen>{
  int count;
  String userID = "13";
  List<dynamic> listItems = new List<dynamic>();

  @override
  void initState() {
    count = 0;
    if(userID==null||userID=="") {
      UserCurrent.getUserID().then((String s) =>
          setState(() {
            userID = s;
          }));
    }
    loadData();
  }
  void loadData() async {
    await fetchGlycemics();
    await fetchActivities();
    await fetchCarbs();
    await fetchMedicine();
    await fetchWeights();
  }

  Future<void> fetchGlycemics() async {
    String url = ip + "/api/getGlycemics.php?userID="+userID;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<GlycemicModel> list = items.map<GlycemicModel>((json) {
        return GlycemicModel.fromJson(json);
      }).toList();

      setState(() {
        list.forEach((element) => listItems.add(element));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchWeights() async {
    String url = ip + "/api/getWeights.php?userID="+userID;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<WeightModel> list = items.map<WeightModel>((json) {
        return WeightModel.fromJson(json);
      }).toList();

      setState(() {
        list.forEach((element) => listItems.add(element));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchActivities() async {
    String url = ip + "/api/getActivities.php?userID="+userID;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<ActivityModel> list = items.map<ActivityModel>((json) {
        return ActivityModel.fromJson(json);
      }).toList();

      setState(() {
        list.forEach((element) => listItems.add(element));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchCarbs() async {
    String url = ip + "/api/getCarbs.php?userID="+userID;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<CarbModel> list = items.map<CarbModel>((json) {
        return CarbModel.fromJson(json);
      }).toList();

      setState(() {
        list.forEach((element) => listItems.add(element));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  Future<void> fetchMedicine() async {
    String url = ip + "/api/getMedicine.php?userID="+userID;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<MedicineModel> list = items.map<MedicineModel>((json) {
        return MedicineModel.fromJson(json);
      }).toList();

      setState(() {
        list.forEach((element) => listItems.add(element));
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  void deleteGlycemic(String id) async {

    var url = ip + "/api/deleteGlycemic.php";
    var response = await http.post(url, body: {
      'id': id,
    });

    var data = json.decode(response.body);
    if(data=="Error"){
      Fluttertoast.showToast(
          msg: "Đã xảy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Xoá thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  void deleteActivity(String id) async {

    var url = ip + "/api/deleteActivity.php";
    var response = await http.post(url, body: {
      'id': id,
    });

    var data = json.decode(response.body);
    if(data=="Error"){
      Fluttertoast.showToast(
          msg: "Đã xảy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Xoá thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  void deleteCarb(String id) async {

    var url = ip + "/api/deleteCarb.php";
    var response = await http.post(url, body: {
      'id': id,
    });

    var data = json.decode(response.body);
    if(data=="Error"){
      Fluttertoast.showToast(
          msg: "Đã xảy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Xoá thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  void deleteMedicine(String id) async {

    var url = ip + "/api/deleteWeight.php";
    var response = await http.post(url, body: {
      'id': id,
    });

    var data = json.decode(response.body);
    if(data=="Error"){
      Fluttertoast.showToast(
          msg: "Đã xảy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Xoá thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  void deleteWeight(String id) async {

    var url = ip + "/api/deleteGlycemic.php";
    var response = await http.post(url, body: {
      'id': id,
    });

    var data = json.decode(response.body);
    if(data=="Error"){
      Fluttertoast.showToast(
          msg: "Đã xảy ra lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Xoá thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
            new Expanded(
                child: ListView.builder(
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
                          press: () async {
                            final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpdateBloodGlucoso(glycemicModel: listItems[index])
                            ));
                            if (result.idModel != null){
                              setState(() {
                                listItems[index] = result;
                              });
                            }
                          },
                          longPress: () async {
                            await showDeleteConfirm(context, "glucoso", listItems[index].id, index);
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
                          press: () async {
                            final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpdateMedicine(medicineModel: listItems[index])
                            ));
                            if (result.idModel != null){
                              setState(() {
                                listItems[index] = result;
                              });
                            }
                          },
                          longPress: () async {
                            await showDeleteConfirm(context, "medicine", listItems[index].id, index);
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
                          press: () async {
                           final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpdateWeight(weightModel: listItems[index])
                            ));
                           if (result.idModel != null){
                             setState(() {
                               listItems[index] = result;
                             });
                           }
                          },
                          longPress: () async {
                            await showDeleteConfirm(context, "weight", listItems[index].id, index);
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
                          press: () async{
                            final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpdateCarbs(carbModel: listItems[index])
                            ));
                            if (result.idModel != null){
                              setState(() {
                                listItems[index] = result;
                              });
                            }
                          },
                          longPress: () async {
                            await showDeleteConfirm(context, "carb", listItems[index].id, index);
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
                          time: listItems[index].activityTime,
                          press: () async{
                            final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpdateExercise(activityModel: listItems[index])
                            ));
                            if (result.idModel != null){
                              setState(() {
                                listItems[index] = result;
                              });
                            }
                          },
                          longPress: () async {
                            await showDeleteConfirm(context, "activity", listItems[index].id, index);
                          },
                          colorPrimary: Colors.green,
                        );
                      }
                    })

            )
          ],
        ),
      ),
    );
  }
  showDeleteConfirm(BuildContext context, String type, String id, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Hủy"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () async {
        switch(type){
          case "glucoso":
            await deleteGlycemic(id);
            setState(() {
              listItems.removeAt(index);
            });
            Navigator.pop(context);
            break;
          case "weight":
            await deleteWeight(id);
            setState(() {
              listItems.removeAt(index);
            });
            Navigator.pop(context);
            break;
          case "activity":
            await deleteActivity(id);
            setState(() {
              listItems.removeAt(index);
            });
            Navigator.pop(context);
            break;
          case "carb":
            await deleteCarb(id);
            setState(() {
              listItems.removeAt(index);
            });
            Navigator.pop(context);
            break;
          case "medicine":
            await deleteMedicine(id);
            setState(() {
              listItems.removeAt(index);
            });
            Navigator.pop(context);
            break;
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Xác nhận"),
      content: Text("Bạn có muốn xóa không?"),
      actions: [
        continueButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


