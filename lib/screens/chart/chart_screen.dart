import 'package:diabetesapp/screens/chart/components/simple_time_chart.dart';
import 'package:diabetesapp/screens/chart/report_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'components/bar_chart_component.dart';

class ChartScreen extends StatefulWidget{
  static String routeName = "/chart_screen";
  @override
  _ChartScreenStateful createState() {
    return _ChartScreenStateful();
  }
}
class _ChartScreenStateful extends State<ChartScreen>{
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleDataTimeSeries() {
    final data1 = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];
    final data2 = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 20),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 125),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 65),
    ];
    final data3 = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 7),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 35),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 60),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 175),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Trước bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data1,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sau bữa ăn',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data2,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Khác',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data3,
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
                  trailing: Text("10 mg/dL"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SimpleTimeSeriesChart(_createSampleDataTimeSeries(), animate: false),
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
}
