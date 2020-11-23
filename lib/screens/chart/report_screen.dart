import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
class ReportScreen extends StatefulWidget{
  static String routeName = "/report_screen";
  @override
  _ReportScreenState createState() {
    return _ReportScreenState();
  }
}
class _ReportScreenState extends State<ReportScreen>{
  String _name = "Toàn Trần";
  String _email = "quoctoan0629@gmail.com";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List _types = ["Đường huyết", "Insulin", "Carbs"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentType;
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentType = _dropDownMenuItems[0].value;
    super.initState();
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo Cáo"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _name,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                    _email
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text("Từ"),
                        FlatButton(onPressed: () async {
                          await DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2020,1,1),
                              maxTime: DateTime(2050,1,1),
                              locale: LocaleType.vi,
                              currentTime: DateTime.now(),
                              onChanged: (date){

                              },
                              onConfirm: (date) {
                                setState(() {
                                  startDate = date;
                                });
                              }
                          );},
                          child: Text(
                            DateFormat("dd/MM/yyyy").format(
                                startDate),
                            style: TextStyle(
                                color: Colors.blue[800],
                                fontFamily: 'Roboto',
                                fontSize: 16)
                        ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text("Đến"),
                        FlatButton(onPressed: () async {
                          await DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2020,1,1),
                              maxTime: DateTime(2050,1,1),
                              locale: LocaleType.vi,
                              currentTime: DateTime.now(),
                              onChanged: (date){

                              },
                              onConfirm: (date) {
                                setState(() {
                                  endDate = date;
                                });
                              }
                          );
                        }, child: Text(
                            DateFormat("dd/MM/yyyy").format(
                                endDate),
                            style: TextStyle(
                                color: Colors.blue[800],
                                fontFamily: 'Roboto',
                                fontSize: 16)
                        ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Thông tin:",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                DropdownButton(
                  value: _currentType,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                )
              ],
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Age',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Role',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Ravi')),
                      DataCell(Text('19')),
                      DataCell(Text('Student')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Jane')),
                      DataCell(Text('43')),
                      DataCell(Text('Professor')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('William')),
                      DataCell(Text('27')),
                      DataCell(Text('Professor')),
                    ],
                  ),
                ],
              )
            )
            
          ],
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentType = selectedCity;
    });
  }
}