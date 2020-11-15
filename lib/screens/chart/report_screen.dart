import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
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
  DateTime _eventStartDate = DateTime.now();
  DateTime _eventEndDate = DateTime.now();
  List _cities =
  ["Cluj-Napoca", "Bucuresti", "Timisoara", "Brasov", "Constanta"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
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
            Column(
              children: [
                ListTile(
                  title: Text("Từ ngày"),
                  subtitle: Text(
                      "${FormatDateTime.convertDayOfWeek(_eventStartDate.weekday)}, ${FormatDateTime.formatDay(_eventStartDate.day)} th ${_eventStartDate.month}, ${_eventStartDate.year} ",
                      style: TextStyle(color: Colors.blue[800])),
                  trailing: Icon(Icons.calendar_today_sharp),
                  onTap: ()async{
                    DateTime picked = await DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
//                    print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
//                  DateTime picked = await showDatePicker(context: context, initialDate: _eventStartDate, firstDate: DateTime(_eventStartDate.year-5), lastDate: DateTime(_eventStartDate.year+5));
                    if(picked != null) {
                      setState(() {
                        _eventStartDate = picked;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text("Đến ngày", style: TextStyle(color: Colors.black),),
                  subtitle: Text(
                      "${FormatDateTime.convertDayOfWeek(_eventEndDate.weekday)}, ${FormatDateTime.formatDay(_eventEndDate.day)} th ${_eventEndDate.month}, ${_eventEndDate.year}",
                      style: TextStyle(color: Colors.blue[800])),
                  trailing: Icon(Icons.calendar_today),
                  onTap: ()async{
                    DateTime picked = await DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                    if(picked != null) {
                      setState(() {
                        _eventEndDate = picked;
                      });
                    }
                  },
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
                  value: _currentCity,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }
}