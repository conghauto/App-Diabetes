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
import 'package:diabetesapp/screens/glucose/log_screens/update_blood_glucoso.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_carbs.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_medicine.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'log_screens/update_exercise.dart';
import 'log_screens/update_weight.dart';

class GlucoseScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  GlucoseScreenState createState() {
    return GlucoseScreenState();
  }
}

class IndexGlycemic{
  double avgG;
  double min;
  double max;

  IndexGlycemic(this.avgG, this.min, this.max);
}

class IndexFood{
  double carbs;
  double cal;

  IndexFood(this.carbs, this.cal);
}

class IndexActivity{
  double cal;
  double time;

  IndexActivity(this.cal, this.time);
}

class Insulin{
  int fastInsulin; // số lượng
  int shortInsulin;
  int avgInsulin;
  int longInsulin;

  Insulin(this.fastInsulin, this.shortInsulin, this.avgInsulin,
      this.longInsulin);

}


class GlucoseScreenState extends State<GlucoseScreen>{
  List<dynamic> listItems = new List<dynamic>();
  List<GlycemicModel> listGlycemics = new List<GlycemicModel>();
  List<CarbModel> listCarbs = new List<CarbModel>();
  List<MedicineModel> listMedicine = new List<MedicineModel>();
  List<ActivityModel> listActivities = new List<ActivityModel>();
  List<WeightModel> listWeights = new List<WeightModel>();
  List<String> query;
  List<String> listInsulin = ["Tác dụng nhanh", "Tác dụng ngắn", "Tác dụng trung bình", "Tác dụng dài"];

  List<double> listIndexGlycemic = new List<double>();

  IndexGlycemic gly = new IndexGlycemic(0,1000,0);
  IndexFood food = new IndexFood(0,0);
  IndexActivity activity = new IndexActivity(0, 0);
  Insulin insulin = new Insulin(0, 0, 0, 0);
  String str = "";
  double currentBG = 0;

  @override
  void initState() {
    sortItems();
  }

  void sortItems() async{
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
            listMedicine.forEach((element) {
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
            // Hiển thị danh sách Glycemic theo khoảng thời gian
            listGlycemics.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate)){
                gly.max=gly.max>double.parse(element.indexG)?gly.max:double.parse(element.indexG);
                gly.min=gly.min>double.parse(element.indexG)?double.parse(element.indexG):gly.min;

                listIndexGlycemic.add(double.parse(element.indexG));
                listItems.add(element);
              }
            });
            // Tính chỉ số trung bình Glycemic
            if(listIndexGlycemic.length!=0){
              listIndexGlycemic.forEach((element) {
                gly.avgG+= element;
              });
              gly.avgG/=listIndexGlycemic.length;
            }

            listCarbs.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate)){
                food.cal+=double.parse(element.calo);
                food.carbs+=double.parse(element.carb);

                listItems.add(element);
              }
            });
            listMedicine.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate)) {
                if (element.typeInsulin == listInsulin[0]) {
                  insulin.fastInsulin += int.parse(element.amount);
                }
                else if (element.typeInsulin == listInsulin[1]) {
                  insulin.shortInsulin += int.parse(element.amount);
                } else if (element.typeInsulin == listInsulin[2]) {
                  insulin.avgInsulin += int.parse(element.amount);
                } else {
                  insulin.longInsulin += int.parse(element.amount);
                }

                listItems.add(element);
              }
            });

            listWeights.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                listItems.add(element);
            });
            listActivities.forEach((element) {
              if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate)){
                activity.cal+=double.parse(element.calo);
                activity.time+=double.parse(element.timeActivity);

                listItems.add(element);
              }
            });

            listItems.sort((b,a) => a.measureTime.compareTo(b.measureTime));
          }
          else {
            if (query[5] == "1") {
              listGlycemics.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate)){
                  gly.max=gly.max>double.parse(element.indexG)?gly.max:double.parse(element.indexG);
                  gly.min=gly.min>double.parse(element.indexG)?double.parse(element.indexG):gly.min;

                  listIndexGlycemic.add(double.parse(element.indexG));
                  listItems.add(element);
                }
              });
              // Tính chỉ số trung bình Glycemic
              if(listIndexGlycemic.length!=0){
                listIndexGlycemic.forEach((element) {
                  gly.avgG+= element;
                });
                gly.avgG/=listIndexGlycemic.length;
              }
            }

            if (query[6] == "2") {
              listCarbs.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate)){
                  food.cal+=double.parse(element.calo);
                  food.carbs+=double.parse(element.carb);

                  listItems.add(element);
                }
              });
            }

            if (query[7] == "3") {
              listMedicine.forEach((element) {
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate))
                  if(element.typeInsulin==listInsulin[0]){
                    insulin.fastInsulin+= int.parse(element.amount);
                  }else if(element.typeInsulin==listInsulin[1]){
                    insulin.shortInsulin+= int.parse(element.amount);
                  }else if(element.typeInsulin==listInsulin[2]){
                    insulin.avgInsulin+= int.parse(element.amount);
                  }else{
                    insulin.longInsulin+= int.parse(element.amount);
                  }

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
                if(element.measureTime.isAfter(startDate)&&element.measureTime.isBefore(endDate)){
                  activity.cal+=double.parse(element.calo);
                  activity.time+=double.parse(element.timeActivity);

                  listItems.add(element);
                }
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
        listMedicine.forEach((element) {
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
          currentBG = double.parse(list[0].indexG.toString());
          list.forEach((element) => listGlycemics.add(element));
        });
      }else{
        currentBG = 0;
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

      setState(() {
        listWeights.sort((b, a) => a.measureTime.compareTo(b.measureTime));
      });
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
        if(listMedicine!=null)
          listMedicine.sort((b, a) => a.measureTime.compareTo(b.measureTime));
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
    }else {
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

    var url = ip + "/api/deleteMedicine.php";
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

  void loadIndexes(List<String>query)async{

    if(query[0]==""&&query[1]=="customDate"&&query[2]!=""&&query[3]!=""){

      listIndexGlycemic = new List<double>();
      gly = new IndexGlycemic(0, 1000, 0);
      insulin = new Insulin(0, 0, 0, 0);
      food = new IndexFood(0,0);
      activity = new IndexActivity(0, 0);

      listItems.forEach((element) {
        if(element.idModel=="1"){
          gly.max=gly.max>double.parse(element.indexG)?gly.max:double.parse(element.indexG);
          gly.min=gly.min>double.parse(element.indexG)?double.parse(element.indexG):gly.min;

          listIndexGlycemic.add(double.parse(element.indexG));
        }else if(element.idModel=="2"){
          if(element.typeInsulin==listInsulin[0]){
            insulin.fastInsulin+= int.parse(element.amount);
          }else if(element.typeInsulin==listInsulin[1]){
            insulin.shortInsulin+= int.parse(element.amount);
          }else if(element.typeInsulin==listInsulin[2]){
            insulin.avgInsulin+= int.parse(element.amount);
          }else{
            insulin.longInsulin+= int.parse(element.amount);
          }
        }else if(element.idModel=="4"){
          food.cal+=double.parse(element.calo);
          food.carbs+=double.parse(element.carb);
        }else if(element.idModel=="5"){
          activity.cal+=double.parse(element.calo);
          activity.time+=double.parse(element.timeActivity);
        }
      });

      // Tính chỉ số trung bình Glycemic
      if(listIndexGlycemic.length!=0){
        listIndexGlycemic.forEach((element) {
          gly.avgG+= element;
        });
        gly.avgG/=listIndexGlycemic.length;
      }
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
                height:  currentBG==0?200:215,
                color: Colors.white,
                child: new Stack(
                  children: <Widget>[
                    Container(
                      height: currentBG==0?170:200,
                      color: kPrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                new Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: new Container(
                                      height: 125.0,
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
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12, fontWeight: FontWeight.bold)
                                                  ),
                                                )
                                              ]
                                          ),
                                          SizedBox(height: 15.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("avg  ",
                                                    style: new TextStyle(color: Colors.blueGrey,fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- ${str} "+"${gly.avgG==0.0?"":gly.avgG.toStringAsFixed(1)}",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontSize: 10, fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("max ",
                                                    style: new TextStyle(color: Colors.blueGrey,fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${gly.max==0.0?"":gly.max.toStringAsFixed(1)}",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("min  ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${gly.min==1000.0?"":gly.min.toStringAsFixed(1)}",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
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
                                      height: 125.0,
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
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12, fontWeight: FontWeight.bold)
                                                  ),
                                                )
                                              ]
                                          ),
                                          SizedBox(height: 20.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("nhanh ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${insulin.fastInsulin==0?"":insulin.fastInsulin.toString()+" viên"} ",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("ngắn ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${insulin.shortInsulin==0?"":insulin.shortInsulin.toString()+" viên"} ",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontSize: 10,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("tb ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${insulin.avgInsulin==0?"":insulin.avgInsulin.toString()+" viên"} ",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("dài ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${insulin.longInsulin==0?"":insulin.longInsulin.toString()+" viên"} ",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
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
                                      height: 125.0,
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
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12, fontWeight: FontWeight.bold)
                                                  ),
                                                )
                                              ]
                                          ),
                                          SizedBox(height: 15.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("carbs ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${food.carbs==0.0?"":food.carbs.toStringAsFixed(1)}",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("cal ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${food.cal==0.0?"":food.cal.toStringAsFixed(1)}",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
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
                                      height: 125.0,
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
                                                            fontFamily: 'Roboto',
                                                            fontSize: 12, fontWeight: FontWeight.bold)
                                                    )
                                                )
                                              ]
                                          ),
                                          SizedBox(height: 15.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("cal   ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)),
                                                new Text("- "+"${activity.cal==0.0?"":activity.cal.toStringAsFixed(1)}",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                              children: <Widget>[
                                                new Text("phút ",
                                                    style: new TextStyle(color: Colors.blueGrey,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12)
                                                ),
                                                new Text("- "+"${activity.time==0.0?"":activity.time.toStringAsFixed(1)}",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ]
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            currentBG==0.0?
                            SizedBox(height: 2,):
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text("Đường huyết hiện tại:    ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 13)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:2.0),
                                  child: currentBG<70.0?
                                  Text("HẠ ĐƯỜNG HUYẾT",
                                      style: TextStyle(color: Colors.red[200],
                                          fontFamily: 'Roboto',
                                          fontSize: 13, fontWeight: FontWeight.bold)
                                  ):currentBG<130.0?
                                  Text("TỐT",
                                      style: TextStyle(color: Colors.green,
                                          fontFamily: 'Roboto',
                                          fontSize: 13, fontWeight: FontWeight.bold)
                                  ):currentBG<180.0?
                                  Text("CHẤP NHẬN ĐƯỢC",
                                      style: TextStyle(color: Colors.yellowAccent,
                                          fontFamily: 'Roboto',
                                          fontSize: 13, fontWeight: FontWeight.bold)
                                  ):
                                  Text("TĂNG ĐƯỜNG HUYẾT",
                                      style: TextStyle(color: Colors.red,
                                          fontFamily: 'Roboto',
                                          fontSize: 13, fontWeight: FontWeight.bold)
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top:  currentBG==0?150:170,
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
                            style: TextStyle(fontSize: 18.0,
                              color: Colors.black,
                              fontFamily: 'Roboto',),
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
            new Expanded(
                child: ListView.builder(
                    itemCount: listItems.length,
                    itemBuilder: (context, index) {
                      if ((listItems[index].idModel=="1")) {
                        return LogCard(
                          iconSrc: "assets/icons/glucose.svg",
                          title: "Đường huyết",
                          nameMedicine: "",
                          unit: "mg/dl",
                          indexValue: listItems[index].indexG,
                          time: listItems[index].measureTime,
                          press: () async {
                            final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpdateBloodGlucoso(glycemicModel: listItems[index])
                            ));
                            if (result != null){
                              setState(() {
                                listItems[index] = result;
                                currentBG = double.parse(result.indexG);
                                loadIndexes(query);
                              });
                            }
                          },
                          longPress: () async {
                            DateTime date = DateTime.now();
                            if(listItems[index].measureTime.year==date.year&&listItems[index].measureTime.month==date.month
                              &&listItems[index].measureTime.day==date.day){
                              currentBG = 0;
                            }
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
                            if (result != null){
                              setState(() {
                                listItems[index] = result;
                                loadIndexes(query);
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
                           if (result != null){
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
                            if (result != null){
                              setState(() {
                                listItems[index] = result;
                                loadIndexes(query);
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
                          time: listItems[index].measureTime,
                          press: () async{
                            final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpdateExercise(activityModel: listItems[index])
                            ));
                            if (result != null){
                              setState(() {
                                listItems[index] = result;
                                loadIndexes(query);
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
              loadIndexes(query);
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
              loadIndexes(query);
            });
            Navigator.pop(context);
            break;
          case "carb":
            await deleteCarb(id);
            setState(() {
              listItems.removeAt(index);
              loadIndexes(query);
            });
            Navigator.pop(context);
            break;
          case "medicine":
            await deleteMedicine(id);
            setState(() {
              listItems.removeAt(index);
              loadIndexes(query);
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


