import 'dart:convert';

import 'package:diabetesapp/components/choice_chip_widget.dart';
import 'package:diabetesapp/components/form_error.dart';
import 'package:diabetesapp/components/multi_choice_chip.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/screens/glucose/add_log_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/add_tab_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:diabetesapp/widgets/ProgressDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class BloodGlucosoLog extends StatefulWidget {
  BloodGlucosoLog({ Key key }) : super(key: key);

  @override
  BloodGlucosoLogState createState() => BloodGlucosoLogState();
}
class BloodGlucosoLogState extends State<BloodGlucosoLog>{

//  final _formKey = GlobalKey<FormState>();

  TextEditingController indexG;
  String userID="";
  TextEditingController note;
  bool isValid=false;

  @override
  void initState(){
    super.initState();
    note = TextEditingController(text:"");
    indexG = TextEditingController(text:"");
    isValid = false;

    if(userID==null||userID=="") {
      UserCurrent.getUserID().then((String s) =>
          setState(() {
            userID = s;
          }));
    }
  }

  void addGlycemic()async{

    // show please wait dialog
//    showDialog(
//      barrierDismissible: false,
//      context: context,
//      builder: (BuildContext context) => ProgressDialog(status: 'Đang xử lý',),
//    );

    var url = ip + "/api/addGlycemic.php";
    var response = await http.post(url, body: {
      'indexG': indexG.text,
      'tags': selectedReportList.length==0?"":selectedReportList.toString(),
      'note': note.text,
      'measureTime': AddLogSceen.time.toString(),
      'userID': userID,
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
          msg: "Thêm thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  List<String> reportList = [
    "Trước bữa sáng",
    "Sau bữa sáng",
    "Trước bữa trưa",
    "Sau bữa trưa",
    "Trước bữa tối",
    "Sau bữa tối",
    "Trước hoạt động",
    "Trong lúc hoạt động",
    "Sau hoạt động",
  ];
  List<String> selectedReportList = List();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top:2.0),
                      child: Text(
                        "Đường huyết",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    title: TextField(
                      controller: indexG,
                      onChanged: (value){
                          if(value.isEmpty){
                            isValid = false;
                          }else{
                            isValid = true;
                          }
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration.collapsed(
                          hintText: "Nhập chỉ số đường huyết"
                      ),
                    ),
                    trailing: Text("mg/dL",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  (selectedReportList.length > 0) ?
                  Container(
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          choiceChipWidget(reportList: selectedReportList),
                          InputChip(
                              backgroundColor: Colors.lightBlueAccent,
                              avatar: CircleAvatar(child: Icon(FontAwesomeIcons.pen)),
                              label: Text("Sửa", style: TextStyle(color: Colors.white),),
                              onSelected: (_) async {
                                await showDialogFunc(context);
                              }
                          )
                        ],
                      )
                  )
                      :
                  ListTile(
                    leading: Text(
                      "Tags",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.blue[900],
                      ),
                    ),
                    title: TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration.collapsed(
                          hintText: "Thêm",
                          enabled: false
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add, color: Colors.black),
                      tooltip: "Thêm mới",
                      onPressed: () async {
                        await showDialogFunc(context);
                      },
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: Text(
                      "Ghi chú",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.blue[900],
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top:12.0),
                      child: TextField(
                        controller: note,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        decoration: InputDecoration.collapsed(
                          hintText: "Nhập ghi chú",
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.note,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
    );
  }

  showDialogFunc(context){
    return showDialog(
      context: context,
      builder: (context){
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color(0xffffc107),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Tags',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Container(
//                      child: Text(
//                        'Thêm tags để tạo log',
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontFamily: 'Roboto',
//                            fontSize: 18.0),
//                      ),
//                    ),
//                  ),
                  SizedBox(height:15),
                  Container(
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          //choiceChipWidget(reportList: this.chipList),
                          MultiSelectChip(
                            reportList,
                            selectedReportList,
                            onSelectionChanged: (selectedList) {
                              setState(() {
                                selectedReportList = selectedList;
                              });
                            },
                          ),
                          InputChip(
                              avatar: CircleAvatar(child: Icon(Icons.add)),
                              label: Text("Thêm mới", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Colors.blue[900]
                              ),),
                              onSelected: (_) async {
                                final result = await Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => AddNewTab())
                                );
                                setState(() {
                                  reportList.add(result);
                                });
                              }
                              )
                        ],
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Container(
                      child: RaisedButton(
                        color: Color(0xffffbf00),
                        child: new Text(
                          'OK',
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                          onPressed: () {
                            Navigator.pop(context);
                        },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                            )
                          ),
                    )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
