import 'dart:convert';

import 'package:diabetesapp/components/choice_chip_widget.dart';
import 'package:diabetesapp/components/multi_choice_chip.dart';
import 'package:diabetesapp/screens/glucose/log_screens/add_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';
import '../../../user_current.dart';
import '../add_log_screen.dart';
class CarbsLog extends StatefulWidget{
  CarbsLog({ Key key }) : super(key: key);
  @override
  CarbsLogState createState() {
    return CarbsLogState();
  }
}
class CarbsLogState extends State<CarbsLog> with AutomaticKeepAliveClientMixin{
  TextEditingController carb;
  TextEditingController fat;
  TextEditingController protein;
  TextEditingController calo;
  TextEditingController note;
  final List<String> errors = [];
  bool isValid=false;

  @override
  void initState(){
    super.initState();
    note = TextEditingController(text:"");
    calo = TextEditingController(text:"");
    carb = TextEditingController(text:"");
    fat = TextEditingController(text:"");
    protein = TextEditingController(text:"");

    setState(() {
      isValid = false;
    });
  }

  void checkCondition(){
    try {
      double valueCarb = double.tryParse(carb.text);
      double valueFat = double.tryParse(fat.text);
      double valueProtein = double.tryParse(protein.text);
      double valueCalo = double.tryParse(calo.text);
      if (valueCarb < 0 || valueFat < 0 || valueProtein < 0 || valueCalo < 0){
        setState(() {
          isValid = false;
        });
      } else {
        setState(() {
          isValid = true;
        });
      }
    } catch (ex){
      setState(() {
        isValid = false;
      });
    }
  }
  void addCarb()async{
    var url = ip + "/api/addCarb.php";
    var response = await http.post(url, body: {
      'carb': carb.text,
      'fat': fat.text,
      'protein': protein.text,
      'calo': calo.text,
      'tags': selectedReportList.length==0?"":selectedReportList.toString(),
      'note': note.text,
      'measureTime': AddLogSceen.time.toString(),
      'userID': UserCurrent.userID.toString(),
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
          msg: "Thêm Carbs thành công",
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
    "Trước khi ngủ",
    "Sau khi ngủ"
  ];
  List<String> selectedReportList = List();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Text(
              "Carbs",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: TextField(
              controller: carb,
              onChanged: (value){
                checkCondition();
              },
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập chỉ số Carbs"
              ),
            ),
            trailing: Text("g"),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            leading: Text(
              "Chất béo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: TextField(
              controller: fat,
              onChanged: (value){
                checkCondition();
              },
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập chỉ số chất béo"
              ),
            ),
            trailing: Text("g"),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            leading: Text(
              "Protein",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: TextField(
              controller: protein,
              onChanged: (value){
                checkCondition();
              },
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập chỉ số protein"
              ),
            ),
            trailing: Text("g"),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            leading: Text(
              "Calories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: TextField(
              controller: calo,
              onChanged: (value){
                checkCondition();
              },
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập chỉ số calo"
              ),
            ),
            trailing: Text("cal"),
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
              ),
            ),
            title: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration.collapsed(
                  hintText: "Add",
                  enabled: false
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.add),
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
              ),
            ),
            title: TextField(
              controller: note,
              textAlign: TextAlign.left,
              maxLines: 3,
              decoration: InputDecoration.collapsed(
                hintText: "Nhập ghi chú",
              ),
            ),
            trailing: Icon(Icons.note),
          )
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
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          'Thêm tags để tạo log',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ),
                    ),
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
                                label: Text("Thêm mới"),
                                onSelected: (_) async {
                                  final result = await Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) => AddNewTab())
                                  );
                                  if (result != null) {
                                    setState(() {
                                      reportList.add(result);
                                    });
                                  }
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}