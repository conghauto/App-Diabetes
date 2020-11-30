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
  Map<DateTime, double> listGlycemics = new Map<DateTime, double>();
  List<TimeSeriesGlycemic> listGlycemicChart = new List<TimeSeriesGlycemic>();
  DateTime startDateGlycemic = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateGlycemic = DateTime.now().add(new Duration(days: 1));
  String _currentTimeGlycemic;
  double averageGlycemic = 0;
  // Activities
  Map<DateTime, double> listActivity = new Map<DateTime, double>();
  List<TimeSeriesGlycemic> listActivityChart = new List<TimeSeriesGlycemic>();
  DateTime startDateActivity = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateActivity = DateTime.now().add(new Duration(days: 1));
  String _currentTimeActivity;
  double averageCaloActivity = 0;
  List _types = ["1 tuần", "1 tháng", "1 năm"];
  // Carb
  Map<DateTime, double> listCarbs = new Map<DateTime, double>();
  List<TimeSeriesGlycemic> listCarbChart = new List<TimeSeriesGlycemic>();
  DateTime startDateCarb = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateCarb = DateTime.now().add(new Duration(days: 1));
  String _currentTimeCarb;
  double averageCarbs = 0;

  // Weight
  Map<DateTime, double> listWeights = new Map<DateTime, double>();
  List<TimeSeriesGlycemic> listWeightChart = new List<TimeSeriesGlycemic>();
  DateTime startDateWeight = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDateWeight = DateTime.now().add(new Duration(days: 1));
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

//    Lấy cân nặng trung bình trong 1 ngày
      List<DateTime> listDateTest = new List<DateTime>();
      Map<DateTime,double> listAvgWeight = new Map<DateTime,double>();

      for(int i=0;i<list.length;i++){
          listDateTest.add(new DateTime.utc(list[i].measureTime.year,list[i].measureTime.month,
              list[i].measureTime.day));
      }
      listDateTest.sort((a,b) => a.compareTo(b));
      listDateTest = listDateTest.toSet().toList();

      for(int i=0;i<listDateTest.length;i++){
        List<double> listWeightOfDay = new List<double>();
        double avg = 0;
        list.forEach((element) {
          if(listDateTest[i].year==element.measureTime.year&&
              listDateTest[i].month==element.measureTime.month&& listDateTest[i].day==element.measureTime.day){
            avg+=double.parse(element.weight);
            listWeightOfDay.add(double.parse(element.weight));
          }
        });

        if(listWeightOfDay!=null){
          avg=double.parse((avg/listWeightOfDay.length).toStringAsFixed(2));
          listAvgWeight[listDateTest[i]]=avg;
        }
      }

      if (list != null) {
        setState(() {
          listWeights = listAvgWeight;
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
    averageWeight = 0;
    if (listWeights != null) {
      listWeights.forEach((date, value) {
        if(date.isAfter(startDate) && date.isBefore(endDate)){
          count++;
          setState(() {
            listWeightChart.add(new TimeSeriesGlycemic(date, value));
            sum += value;
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
//    Lấy thức ăn trung bình trong 1 ngày
      List<DateTime> listDateTest = new List<DateTime>();
      Map<DateTime,double> listAvgCarb = new Map<DateTime,double>();

      for(int i=0;i<list.length;i++){
        listDateTest.add(new DateTime.utc(list[i].measureTime.year,list[i].measureTime.month,
            list[i].measureTime.day));
      }
      listDateTest.sort((a,b) => a.compareTo(b));
      listDateTest = listDateTest.toSet().toList();

      for(int i=0;i<listDateTest.length;i++){
        List<double> listCarbOfDay = new List<double>();
        double avg = 0;
        list.forEach((element) {
          if(listDateTest[i].year==element.measureTime.year&&
              listDateTest[i].month==element.measureTime.month&& listDateTest[i].day==element.measureTime.day){
            avg+=double.parse(element.carb);
            listCarbOfDay.add(double.parse(element.carb));
          }
        });

        if(listCarbOfDay!=null){
          avg=double.parse((avg/listCarbOfDay.length).toStringAsFixed(2));
          listAvgCarb[listDateTest[i]]=avg;
        }
      }
      if (list != null) {
        setState(() {
          listCarbs = listAvgCarb;
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
    averageCarbs = 0;
    if (listCarbs != null) {
      listCarbs.forEach((date, value) {
        if(date.isAfter(startDate) && date.isBefore(endDate)){
          count++;
          setState(() {
            listCarbChart.add(new TimeSeriesGlycemic(date, value));
            sum += value;
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
      //    Lấy năng lượng tiêu hao trung bình trong 1 ngày
      List<DateTime> listDateTest = new List<DateTime>();
      Map<DateTime,double> listAvgCalo = new Map<DateTime,double>();

      for(int i=0;i<list.length;i++){
        listDateTest.add(new DateTime.utc(list[i].measureTime.year,list[i].measureTime.month,
            list[i].measureTime.day));
      }
      listDateTest.sort((a,b) => a.compareTo(b));
      listDateTest = listDateTest.toSet().toList();

      for(int i=0;i<listDateTest.length;i++){
        List<double> listCaloOfDay = new List<double>();
        double avg = 0;
        list.forEach((element) {
          if(listDateTest[i].year==element.measureTime.year&&
              listDateTest[i].month==element.measureTime.month&& listDateTest[i].day==element.measureTime.day){
            avg+=double.parse(element.calo);
            listCaloOfDay.add(double.parse(element.calo));
          }
        });

        if(listCaloOfDay!=null){
          avg=double.parse((avg/listCaloOfDay.length).toStringAsFixed(2));
          listAvgCalo[listDateTest[i]]=avg;
        }
      }

      if (list != null) {
        setState(() {
          listActivity = listAvgCalo;
        });
        filterActivity(this.startDateGlycemic, this.endDateGlycemic);
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  void filterActivity(DateTime startDate, DateTime endDate) {
    listActivityChart = new List();
    int count = 0;
    double sum = 0;
    averageCaloActivity = 0;
    if (listActivity != null) {
      listActivity.forEach((date, value) {
        if(date.isAfter(startDate) && date.isBefore(endDate)){
          count++;
          sum += value;
            setState(() {
              listActivityChart.add(new TimeSeriesGlycemic(date, value));
            });
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

      //    Lấy lượng đường huyết trung bình trong 1 ngày
      List<DateTime> listDateTest = new List<DateTime>();
      Map<DateTime,double> listAvgGlycemic = new Map<DateTime,double>();

      for(int i=0;i<list.length;i++){
        listDateTest.add(new DateTime.utc(list[i].measureTime.year,list[i].measureTime.month,
            list[i].measureTime.day));
      }
      listDateTest.sort((a,b) => a.compareTo(b));
      listDateTest = listDateTest.toSet().toList();

      for(int i=0;i<listDateTest.length;i++){
        List<double> listGlycemicOfDay = new List<double>();
        double avg = 0;
        list.forEach((element) {
          if(listDateTest[i].year==element.measureTime.year&&
              listDateTest[i].month==element.measureTime.month&& listDateTest[i].day==element.measureTime.day){
            avg+=double.parse(element.indexG);
            listGlycemicOfDay.add(double.parse(element.indexG));
          }
        });

        if(listGlycemicOfDay!=null){
          avg=double.parse((avg/listGlycemicOfDay.length).toStringAsFixed(2));
          listAvgGlycemic[listDateTest[i]]=avg;
        }
      }
      if (list != null) {
        setState(() {
          listGlycemics = listAvgGlycemic;
        });
        filterGlycemics(this.startDateGlycemic, this.endDateGlycemic);
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  void filterGlycemics(DateTime startDate, DateTime endDate) {
    listGlycemicChart = new List();
    int count = 0;
    double sum = 0;
    averageGlycemic = 0;
    if (listGlycemics != null) {
      listGlycemics.forEach((date, value) {
        if(date.isAfter(startDate) && date.isBefore(endDate)){
          count++;
          sum+= value;
            setState(() {
              listGlycemicChart.add(new TimeSeriesGlycemic(date, value));
            });
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
        id: 'Đường huyết',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listGlycemicChart,
      )
    ];
  }
  List<charts.Series<TimeSeriesGlycemic, DateTime>> _createActivityDataTimeSeries() {
    return [
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Năng lượng tiêu hao',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.data,
        data: listActivityChart,
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