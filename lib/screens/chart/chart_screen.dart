import 'dart:convert';

import 'package:diabetesapp/models/activity.dart';
import 'package:diabetesapp/models/carb.dart';
import 'package:diabetesapp/models/glycemic.dart';
import 'package:diabetesapp/models/weight.dart';
import 'package:diabetesapp/screens/chart/components/simple_time_chart.dart';
import 'package:diabetesapp/screens/chart/report_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../constants.dart';
import '../../user_current.dart';
import 'components/bar_chart_component.dart';
import 'package:http/http.dart' as http;
class ChartScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  _ChartScreenStateful createState() {
    return _ChartScreenStateful();
  }
}
class _ChartScreenStateful extends State<ChartScreen>{
  // Glycemic
  List<GlycemicModel> listGlycemics = new List<GlycemicModel>();
  List<TimeSeriesGlycemic> listBeforeMeal = new List<TimeSeriesGlycemic>();
  List<TimeSeriesGlycemic> listAfterMeal = new List<TimeSeriesGlycemic>();
  List<TimeSeriesGlycemic> listOthers = new List<TimeSeriesGlycemic>();
  DateTime startDateGlycemic = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateGlycemic = DateTime.now();
  String _currentTimeGlycemic;
  double averageGlycemic = 0;
  // Activities
  List<ActivityModel> listActivity = new List<ActivityModel>();
  List<TimeSeriesGlycemic> listActivityBeforeMeal = new List<TimeSeriesGlycemic>();
  List<TimeSeriesGlycemic> listActivityAfterMeal = new List<TimeSeriesGlycemic>();
  List<TimeSeriesGlycemic> listActivityOthers = new List<TimeSeriesGlycemic>();
  DateTime startDateActivity = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateActivity = DateTime.now();
  String _currentTimeActivity;
  double averageCaloActivity = 0;
  List _types = ["1 tuần", "1 tháng", "1 năm"];
  // Carb
  List<CarbModel> listCarbs = new List<CarbModel>();
  List<TimeSeriesGlycemic> listCarbChart = new List<TimeSeriesGlycemic>();
  DateTime startDateCarb = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateCarb = DateTime.now();
  String _currentTimeCarb;
  double averageCarbs = 0;

  // Weight
  List<WeightModel> listWeights = new List<WeightModel>();
  List<TimeSeriesGlycemic> listWeightChart = new List<TimeSeriesGlycemic>();
  DateTime startDateWeight = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateWeight = DateTime.now();
  String _currentTimeWeight;
  double averageWeight = 0;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuActivityItems;
  List<DropdownMenuItem<String>> _dropDownMenuCarbItems;
  List<DropdownMenuItem<String>> _dropDownMenuWeightItems;
  @override
  void initState() {
    // fetch glycemic data
    _dropDownMenuItems = getDropDownMenuItems();
    _currentTimeGlycemic = _dropDownMenuItems[0].value;
    fetchGlycemics();

    // fetch calo activity
    _dropDownMenuActivityItems = getDropDownMenuItems();
    _currentTimeActivity = _dropDownMenuActivityItems[0].value;
    fetchActivities();
    // fetch carb
    _dropDownMenuCarbItems = getDropDownMenuItems();
    _currentTimeCarb = _dropDownMenuCarbItems[0].value;
    fetchCarbs();

    //fetch weight
    _dropDownMenuWeightItems = getDropDownMenuItems();
    _currentTimeWeight = _dropDownMenuWeightItems[0].value;
    fetchWeight();
  }
  Future<void> fetchWeight() async {
    String url = ip + "/api/getWeights.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<WeightModel> list= items.map<WeightModel>((json) {
        return WeightModel.fromJson(json);
      }).toList();

      if (list != null) {
        setState(() {
          listWeights = list;
        });
        filterWeight(this.startDateWeight, this.endDateWeight);
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  void filterWeight(DateTime startDate, DateTime endDate) {
    listWeightChart = new List();
    int count = 0;
    double sum = 0;
    if (listWeights != null) {
      listWeights.forEach((element) {
        if(element.measureTime.isAfter(startDate) && element.measureTime.isBefore(endDate)){
          count++;
          setState(() {
            listWeightChart.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.weight)));
            sum += double.tryParse(element.weight);
          });
        }
      });
      if (count != 0) {
        setState(() {
          averageWeight = sum/count;
        });
      }
    }
  }

  Future<void> fetchCarbs() async {
    String url = ip + "/api/getCarbs.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<CarbModel> list= items.map<CarbModel>((json) {
        return CarbModel.fromJson(json);
      }).toList();

      if (list != null) {
        setState(() {
          listCarbs = list;
        });
        filterCarb(this.startDateCarb, this.endDateCarb);
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  void filterCarb(DateTime startDate, DateTime endDate) {
    listCarbChart = new List();
    int count = 0;
    double sum = 0;
    if (listCarbs != null) {
      listCarbs.forEach((element) {
        if(element.measureTime.isAfter(startDate) && element.measureTime.isBefore(endDate)){
          count++;
          setState(() {
            listCarbChart.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.carb)));
            sum += double.tryParse(element.carb);
          });
        }
      });
      if (count != 0) {
        setState(() {
          averageCarbs = sum/count;
        });
      }
    }
  }

  Future<void> fetchActivities() async {
    String url = ip + "/api/getActivities.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<ActivityModel> list= items.map<ActivityModel>((json) {
        return ActivityModel.fromJson(json);
      }).toList();

      if (list != null) {
        setState(() {
          listActivity = list;
        });
        filterActivity(this.startDateGlycemic, this.endDateGlycemic);
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  void filterActivity(DateTime startDate, DateTime endDate) {
    listActivityBeforeMeal = new List();
    listActivityAfterMeal = new List();
    listActivityOthers = new List();
    int count = 0;
    double sum = 0;
    if (listActivity != null) {
      listActivity.forEach((element) {
        if(element.measureTime.isAfter(startDate) && element.measureTime.isBefore(endDate)){
          count++;
          sum += double.tryParse(element.calo);
          if (element.tags.contains("Trước bữa")){
            setState(() {
              listActivityBeforeMeal.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.calo)));
            });
          }
          if (element.tags.contains("Sau bữa")){
            setState(() {
              listActivityAfterMeal.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.calo)));
            });
          }
          if (!element.tags.contains("Trước bữa") && !element.tags.contains("Sau bữa")){
            setState(() {
              listActivityOthers.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.calo)));
            });
          }
        }
      });
      if (count != 0) {
        setState(() {
          averageCaloActivity = sum/count;
        });
      }
    }
  }


  Future<void> fetchGlycemics() async {
    String url = ip + "/api/getGlycemics.php?userID="+UserCurrent.userID.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<GlycemicModel> list= items.map<GlycemicModel>((json) {
        return GlycemicModel.fromJson(json);
      }).toList();

      if (list != null) {
        setState(() {
          listGlycemics = list;
        });
        filterGlycemics(this.startDateGlycemic, this.endDateGlycemic);
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  void filterGlycemics(DateTime startDate, DateTime endDate) {
    listBeforeMeal = new List();
    listAfterMeal = new List();
    listOthers = new List();
    int count = 0;
    double sum = 0;
    if (listGlycemics != null) {
      listGlycemics.forEach((element) {
        if(element.measureTime.isAfter(startDate) && element.measureTime.isBefore(endDate)){
          count++;
          sum+= double.tryParse(element.indexG);
          if (element.tags.contains("Trước bữa")){
            setState(() {
              listBeforeMeal.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.indexG)));
            });
          }
          if (element.tags.contains("Sau bữa")){
            setState(() {
              listAfterMeal.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.indexG)));
            });
          }
          if (!element.tags.contains("Trước bữa") && !element.tags.contains("Sau bữa")){
            setState(() {
              listOthers.add(new TimeSeriesGlycemic(element.measureTime, double.tryParse(element.indexG)));
            });
          }
        }
      });
      if (count != 0) {
        setState(() {
          averageGlycemic = sum/count;
        });
      }
    }
  }

  List<charts.Series<TimeSeriesGlycemic, DateTime>> _createWeightDataTimeSeries() {
    return [
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Weight',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listWeightChart,
      )
    ];
  }
  List<charts.Series<TimeSeriesGlycemic, DateTime>> _createCarbDataTimeSeries() {
    return [
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Carb',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listCarbChart,
      )
    ];
  }
  List<charts.Series<TimeSeriesGlycemic, DateTime>> _createGlycemicDataTimeSeries() {
    return [
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Trước bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listBeforeMeal,
      ),
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Sau bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listAfterMeal,
      ),
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Khác',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listOthers,
      )
    ];
  }
  List<charts.Series<TimeSeriesGlycemic, DateTime>> _createActivityDataTimeSeries() {
    return [
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Trước bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listActivityBeforeMeal,
      ),
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Sau bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listActivityAfterMeal,
      ),
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Khác',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listActivityOthers,
      )
    ];
  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String type in _types) {
      items.add(new DropdownMenuItem(
          value: type,
          child: new Text(type)
      ));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListTile(
            title: Text(
              "REPORT",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            trailing: IconButton(
              icon: Icon(Icons.print),
              onPressed: () async{
                await Navigator.pushNamed(context, ReportScreen.routeName);
              },
            ),
          ),
          Divider(
            height: 5,
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "Carb",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                  title: Text(
                    "Thời gian:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: DropdownButton(
                    value: _currentTimeCarb,
                    items: _dropDownMenuCarbItems,
                    onChanged: changedDropDownItemCarb,
                  )
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleTimeSeriesChart(_createCarbDataTimeSeries(), animate: false),
                ),
                ListTile(
                  title: Text(
                    "Carb trung bình: ${averageCarbs.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 5,
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "Hoạt động",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                  title: Text(
                    "Thời gian:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: DropdownButton(
                    value: _currentTimeActivity,
                    items: _dropDownMenuActivityItems,
                    onChanged: changedDropDownItemActivity,
                  )
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleTimeSeriesChart(_createActivityDataTimeSeries(), animate: false),
                ),
                ListTile(
                  title: Text(
                    "KCAL sử dụng trung bình: ${averageCaloActivity.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 5,
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "Đường huyết",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                  title: Text(
                    "Thời gian:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: DropdownButton(
                    value: _currentTimeGlycemic,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItemGlycemic,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleTimeSeriesChart(_createGlycemicDataTimeSeries(), animate: false),
                ),
                ListTile(
                  title: Text(
                    "Đường huyết trung bình: ${averageGlycemic.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 5,
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "Cân nặng",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                  title: Text(
                    "Thời gian:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: DropdownButton(
                    value: _currentTimeWeight,
                    items: _dropDownMenuWeightItems,
                    onChanged: changedDropDownItemWeight,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleTimeSeriesChart(_createWeightDataTimeSeries(), animate: false),
                ),
                ListTile(
                  title: Text(
                    "Cân nặng trung bình: ${averageWeight.toStringAsFixed(2)} kg",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  void changedDropDownItemGlycemic(String selectedTime) {
    setState(() {
      _currentTimeGlycemic = selectedTime;
      if (selectedTime == "1 tuần"){
        this.startDateGlycemic = DateTime.now().subtract(Duration(days: 7));
      } else if (selectedTime == "1 tháng") {
        this.startDateGlycemic = DateTime.now().subtract(Duration(days: 30));
      } else if (selectedTime == "1 năm") {
        this.startDateGlycemic = DateTime.now().subtract(Duration(days: 365));
      }
    });
    filterGlycemics(startDateGlycemic, endDateGlycemic);
  }

  void changedDropDownItemActivity(String selectedTime) {
    setState(() {
      _currentTimeActivity = selectedTime;
      if (selectedTime == "1 tuần"){
        this.startDateActivity = DateTime.now().subtract(Duration(days: 7));
      } else if (selectedTime == "1 tháng") {
        this.startDateActivity = DateTime.now().subtract(Duration(days: 30));
      } else if (selectedTime == "1 năm") {
        this.startDateActivity = DateTime.now().subtract(Duration(days: 365));
      }
    });
    filterActivity(startDateActivity, endDateActivity);
  }


  void changedDropDownItemCarb(String selectedTime) {
    setState(() {
      _currentTimeCarb = selectedTime;
      if (selectedTime == "1 tuần"){
        this.startDateCarb = DateTime.now().subtract(Duration(days: 7));
      } else if (selectedTime == "1 tháng") {
        this.startDateCarb = DateTime.now().subtract(Duration(days: 30));
      } else if (selectedTime == "1 năm") {
        this.startDateCarb = DateTime.now().subtract(Duration(days: 365));
      }
    });
    filterCarb(startDateCarb, endDateCarb);
  }

  void changedDropDownItemWeight(String selectedTime) {
    setState(() {
      _currentTimeWeight = selectedTime;
      if (selectedTime == "1 tuần"){
        this.startDateWeight = DateTime.now().subtract(Duration(days: 7));
      } else if (selectedTime == "1 tháng") {
        this.startDateWeight = DateTime.now().subtract(Duration(days: 30));
      } else if (selectedTime == "1 năm") {
        this.startDateWeight = DateTime.now().subtract(Duration(days: 365));
      }
    });
    filterWeight(startDateWeight, endDateWeight);
  }
}