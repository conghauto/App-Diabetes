import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:diabetesapp/models/filter-service.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectFilter extends StatefulWidget {

  SelectFilter({Key key}) : super(key: key);

  @override
  _SelectFilterState createState() => _SelectFilterState();
}

enum SelectDate {
  allDate,
  customDate,
}

class OptionDate{
  final String select;
  final int id;

  OptionDate(this.select, this.id);
}

class OptionType{
  final String select;
  final int id;

  OptionType(this.select, this.id);
}

class _SelectFilterState extends State<SelectFilter> {
  var tmpArray = [];
  DateTime startDate=new DateTime(2020,01,04);
  DateTime endDate=new DateTime.now();
  FilterService query;
  List<String>listQuery;

  @override
  void initState() {
    setState(() {
      query = new FilterService("", "",
          null, null, 10, 10,
          10, 10, 10, 10);
    });

    getListQuery();
  }

  void getListQuery()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listQuery = prefs.getStringList('query');

    setState(() {
      if (listQuery == null) {
        valuesOfDateTime["allDate"] = true;
        for (OptionType key in valuesOfType.keys) {
          if (key.id == 0)
            valuesOfType[key] = true;
        }
      }
      else {
        if(listQuery[2]!=""&&listQuery[3]!="") {
           startDate = DateTime.parse(listQuery[2]);
           endDate = DateTime.parse(listQuery[3]);
        }

        if (listQuery[0] == "allDate") {
          valuesOfDateTime["allDate"] = true;
        }

        if (listQuery[1] == "customDate") {
          valuesOfDateTime["customDate"] = true;
        }
        for (OptionType key in valuesOfType.keys)
        {
          if (listQuery[4] == "0") {
            if (key.id == 0)
              valuesOfType[key] = true;
          }
          if (listQuery[5] == "1") {
            if (key.id == 1)
              valuesOfType[key] = true;
          }
          if (listQuery[6] == "2") {
            if (key.id == 2)
              valuesOfType[key] = true;
          }
          if (listQuery[7] == "3") {
            if (key.id == 3)
              valuesOfType[key] = true;
          }
          if (listQuery[8] == "4") {
            if (key.id == 4)
              valuesOfType[key] = true;
          }
          if (listQuery[9] == "5") {
            if (key.id == 5)
              valuesOfType[key] = true;
          }
        }

        // Set token query
      }
    });
  }

//  Map<OptionDate, bool> valuesOfDateTime = {
//    OptionDate("Tất cả",1): false,
//    OptionDate("Chọn ngày",2): false,
//  };

  Map<String, bool> valuesOfDateTime = {
    "allDate": false,
    "customDate": false,
  };

  Map<OptionType, bool> valuesOfType = {
    OptionType('Tất cả',0): false,
    OptionType('Đường huyết',1): false,
    OptionType('Thức ăn',2): false,
    OptionType('Thuốc',3): false,
    OptionType('Cân nặng',4): false,
    OptionType('Hoạt động',5): false,
  };

//  getCheckboxItems() {
//    widget.values.forEach((key, value) {
//      if (value == true) {
//        tmpArray.add(key);
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sắp xếp theo loại'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              });
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.save_outlined),
                onPressed: () async{
                  setState(() {

                  });

                  if(valuesOfDateTime["allDate"]==true){
                    query.allDate="allDate";
                  }

                  if(valuesOfDateTime["customDate"]==true){
                    query.customDate="customDate";
                  }

                  for (OptionType key in valuesOfType.keys) {
                    if(valuesOfType[key]==true){
                      switch(key.id){
                        case 0:
                          query.allType=0;
                          break;
                        case 1:
                          query.glycemicType=1;
                          break;
                        case 2:
                          query.foodType=2;
                          break;
                        case 3:
                          query.medicineType=3;
                          break;
                        case 4:
                          query.weightType=4;
                          break;
                        case 5:
                          query.activityType=5;
                          break;
                        default:
                          break;
                      }
                    }
                  }

                  List<String> list=new List<String>();
                  list.add(query.allDate);
                  list.add(query.customDate);

                  if(valuesOfDateTime["allDay"]==true||valuesOfDateTime["customDate"]==false){
                    list.add("");
                    list.add("");
                  }
                  else {
                    query.startDate=startDate;
                    query.endDate=endDate;
                    list.add(query.startDate.toString());
                    list.add(query.endDate.toString());
                  }

                  list.add(query.allType.toString());
                  list.add(query.glycemicType.toString());
                  list.add(query.foodType.toString());
                  list.add(query.medicineType.toString());
                  list.add(query.weightType.toString());

                  list.add(query.activityType.toString());

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setStringList('query', list);

                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                })
          ],
        ),
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: valuesOfDateTime["customDate"] == true?2:1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white12,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0,left:10.0, bottom: 5.0),
                                child: Text('Hiển thị theo ngày',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontSize: 17),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(flex:valuesOfDateTime["customDate"] == true?3:2,child:
                              CheckboxListTile(
                                title: new Text("Tất cả"),
                                value: valuesOfDateTime["allDate"],
                                activeColor: Colors.pink,
                                checkColor: Colors.white,
                                onChanged: (bool value) {
                                  setState(() {
                                  valuesOfDateTime["allDate"] = value;
                                  valuesOfDateTime["customDate"] = !value;
                                  if(valuesOfDateTime["allDate"]==true){
                                    query.allDate="allDate";
                                    query.customDate="";
                                  }else{
                                    query.allDate="";
                                    query.customDate="customDate";
                                  }
                                  });
                                },
                              ),
                              ),
                            Expanded(flex:valuesOfDateTime["customDate"] == true?3:2,
                                child: Column(
                                  children: [
                                    CheckboxListTile(
                                      title: new Text("Chọn ngày"),
                                      value: valuesOfDateTime["customDate"],
                                      activeColor: Colors.pink,
                                      checkColor: Colors.white,
                                      onChanged: (bool value) {
                                        setState(() {
                                          valuesOfDateTime["customDate"] = value;
                                          valuesOfDateTime["allDate"] = !value;
                                          if(valuesOfDateTime["customDate"]==true){
                                            query.customDate="customDate";
                                            query.allDate="";
                                          }else{
                                            query.customDate="";
                                            query.allDate="allDate";
                                          }
                                        });
                                      },
                                    ),


                                  ],
                                )
                            ),
                            valuesOfDateTime["customDate"] == true?
                            Expanded(flex: 5,child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                        children: [
                                          Text("Từ"),
                                          FlatButton(onPressed: () async {
                                            final DateTime picked = await showDatePicker(
                                              context: context,
                                              initialDate: startDate,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2050),
                                              initialEntryMode: DatePickerEntryMode
                                                  .input,
                                              helpText: 'Từ ngày',
                                              // Can be used as title
                                              cancelText: 'Hủy bỏ',
                                              confirmText: 'Chọn',
                                              errorFormatText: 'Nhập ngày hợp lệ',
                                              errorInvalidText: 'Ngày không hợp lệ',
                                              fieldLabelText: 'Nhập ngày',
                                              fieldHintText: 'dd/mm/yyyy',
                                            );
                                            if (picked != null &&
                                                picked != startDate)
                                              setState(() {
                                                startDate = picked;
//                                                query.startDate=startDate;
                                              });
                                          }, child: Text(
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
                                        Text("Từ"),
                                        FlatButton(onPressed: () async {
                                          final DateTime picked = await showDatePicker(
                                            context: context,
                                            initialDate: endDate,
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2050),
                                            initialEntryMode: DatePickerEntryMode
                                                .input,
                                            helpText: 'Từ ngày',
                                            // Can be used as title
                                            cancelText: 'Hủy bỏ',
                                            confirmText: 'Chọn',
                                            errorFormatText: 'Nhập ngày hợp lệ',
                                            errorInvalidText: 'Ngày không hợp lệ',
                                            fieldLabelText: 'Nhập ngày',
                                            fieldHintText: 'dd/mm/yyyy',
                                          );
                                          if (picked != null &&
                                              picked != endDate)
                                            setState(() {
                                              endDate = picked;
//                                              query.endDate=endDate;
                                            });
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
                            ))
                                : SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Divider(
                  height: 5,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white12,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0,left:10.0, bottom: 5.0),
                                  child: Text('Hiển thị theo loại',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 17),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                        Expanded(child: ListView(
//                            physics: const NeverScrollableScrollPhysics(),
                            children: valuesOfType.keys.map((OptionType key) {
                              return new CheckboxListTile(
                                title: new Text(key.select),
                                value: valuesOfType[key],
                                activeColor: Colors.pink,
                                checkColor: Colors.white,
                                onChanged: (bool value) {
                                  setState(() {
                                    valuesOfType[key] = value;

                                    if(key.id==0&&valuesOfType[key]==true){
                                      for (OptionType k in valuesOfType.keys) {
                                        if (k.id != 0){
                                          valuesOfType[k] = false;
                                        }
                                      }
                                        query.allType=0;
                                        query.glycemicType=10;
                                        query.activityType=10;
                                        query.medicineType=10;
                                        query.foodType=10;
                                        query.weightType=10;
                                    }
                                    else if(key.id!=0&&valuesOfType[key]==true)
                                    {
                                      for (OptionType op in valuesOfType.keys)
                                      {
                                        if (op.id == 0){
                                          valuesOfType[op] = false;
                                          query.allType=-1;
                                        }
                                      }
                                    }

                                  });
                                },
                              );
                            }).toList()
                        )),
                      ],
                    )
                ),
              ],
            )
        )
    );
  }

//  void search(){
//    List<dynamic>list=List<dynamic>();
//    widget.listItems.forEach((element) {
//        if(query.glycemicType==1){
//          list.add(element);
//        }
//    });
//  }
}

