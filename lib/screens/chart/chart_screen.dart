import 'dart:convert';

import 'package:diabetesapp/models/glycemic.dart';
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
  List<GlycemicModel> listGlycemics = new List<GlycemicModel>();
  List<TimeSeriesGlycemic> listBeforeMeal = new List<TimeSeriesGlycemic>();
  List<TimeSeriesGlycemic> listAfterMeal = new List<TimeSeriesGlycemic>();
  List<TimeSeriesGlycemic> listOthers = new List<TimeSeriesGlycemic>();
  DateTime startDate = DateTime.now().subtract(new Duration(days: 7));
  DateTime endDate = DateTime.now();
  List _types = ["1 tuần", "1 tháng", "1 năm"];
  String _currentTime;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentTime = _dropDownMenuItems[0].value;
    fetchGlycemics();
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
        filterGlycemics(this.startDate, this.endDate);
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
    if (listGlycemics != null) {
      listGlycemics.forEach((element) {
        if(element.measureTime.isAfter(startDate) && element.measureTime.isBefore(endDate)){
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
    }
  }
  List<charts.Series<TimeSeriesGlycemic, DateTime>> _createGlycemicDataTimeSeries() {
    return [
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Trước bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.glycemic,
        data: listBeforeMeal,
      ),
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Sau bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.glycemic,
        data: listAfterMeal,
      ),
      new charts.Series<TimeSeriesGlycemic, DateTime>(
        id: 'Khác',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesGlycemic sales, _) => sales.time,
        measureFn: (TimeSeriesGlycemic sales, _) => sales.glycemic,
        data: listOthers,
      )
    ];
  }
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 25),
      new OrdinalSales('2019', 100),
      new OrdinalSales('2020', 75),
    ];

    final tabletSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
      new OrdinalSales('2018', 50),
      new OrdinalSales('2019', 10),
      new OrdinalSales('2020', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
      new OrdinalSales('2018', 15),
      new OrdinalSales('2019', 50),
      new OrdinalSales('2020', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Trước bữa ăn',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.red),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Sau bữa ăn',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blueAccent),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Khác',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.green),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
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
                    "Đường huyết",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                  title: Text(
                    "1 tuần:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: Text("10 mg/dL"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleSeriesLegend(_createSampleData(), animate: false),
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
                    "1 tuần:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: Text("10 mg/dL"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleSeriesLegend(_createSampleData(), animate: false),
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
                    "1 tuần:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: DropdownButton(
                    value: _currentTime,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleTimeSeriesChart(_createGlycemicDataTimeSeries(), animate: false),
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
                    "1 tuần:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: Text("10 mg/dL"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleSeriesLegend(_createSampleData(), animate: false),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  void changedDropDownItem(String selectedTime) {
    setState(() {
      _currentTime = selectedTime;
      if (selectedTime == "1 tuần"){
        this.startDate = DateTime.now().subtract(Duration(days: 7));
      } else if (selectedTime == "1 tháng") {
        this.startDate = DateTime.now().subtract(Duration(days: 30));
      } else if (selectedTime == "1 năm") {
        this.startDate = DateTime.now().subtract(Duration(days: 365));
      }
    });
    filterGlycemics(startDate, endDate);
  }
}
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}