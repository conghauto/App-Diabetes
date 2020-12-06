import 'dart:convert';
import 'package:diabetesapp/components/choice_chip_widget.dart';
import 'package:diabetesapp/components/multi_choice_chip.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/models/glycemic.dart';
import 'package:diabetesapp/screens/glucose/log_screens/add_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
import '../../../size_config.dart';
import '../../../user_current.dart';
class UpdateBloodGlucoso extends StatefulWidget {
  UpdateBloodGlucoso({this.glycemicModel});
  static String routeName = "/update_glucoso_screen";
  GlycemicModel glycemicModel;

  @override
  _UpdateBloodGlucosoState createState() => _UpdateBloodGlucosoState();
}
class _UpdateBloodGlucosoState extends State<UpdateBloodGlucoso> {
  double value = 0;
  GlycemicModel glycemicModelBack;
  TextEditingController indexG;
  String id = "";
  TextEditingController note;
  bool isValid=false;
  DateTime time;
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
  void initState(){
    super.initState();
    note = TextEditingController(text: widget.glycemicModel.note);
    indexG = TextEditingController(text: widget.glycemicModel.indexG);
    id = widget.glycemicModel.id;
    time = widget.glycemicModel.measureTime;
    String listTags = widget.glycemicModel.tags;
    if (listTags.length > 0){
      listTags = listTags.substring(1, listTags.length - 1);
      if (listTags.contains(",")){// remove [ ]
        selectedReportList = listTags.split(", ");
      } else {
        selectedReportList.add(listTags);
      }

      // Insert choice to list
      for(String choice in selectedReportList){
        int isDupicate = -1;
        for(int i = 0; i < reportList.length; i++){
          if (choice == reportList[i]){
            isDupicate = i;
          }
        }
        if (isDupicate == -1){
          reportList.add(choice);
        }
      }
    }
  }

  void updateGlycemic() async {

    var url = ip + "/api/updateGlycemic.php";
    var response = await http.post(url, body: {
      'indexG': indexG.text,
      'tags': selectedReportList.length== 0 ? "" :selectedReportList.toString(),
      'note': note.text,
      'measureTime': time.toString(),
      'id': id,
      'fullname': UserCurrent.fullName.toString(),
      'emailRelative': UserCurrent.emailRelative.toString()
    });
    glycemicModelBack = new GlycemicModel(id: id, indexG: indexG.text, note: note.text, tags: selectedReportList.length==0?"":selectedReportList.toString(), measureTime: time, idModel: widget.glycemicModel.idModel, userID: widget.glycemicModel.userID);
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
          msg: "Cập nhật đường huyết thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Đóng',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Update")
      ),
      body: Container(
        child: ListView(
          children: [
            new Card(
              child: new ListTile(
                leading: const Icon(Icons.timer),
                title: new TextField(
                  decoration: InputDecoration(hintText: "${FormatDateTime.convertDayOfWeek(time.weekday)}, ${FormatDateTime.formatDay(time.day)} th ${time.month}, ${time.year}  ${FormatDateTime.formatHour(time.hour)}:${FormatDateTime.formatMinute(time.minute)}", enabled: false),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: "Sửa thời gian",
                  onPressed: () async {
                    DateTime picked = await DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
                    }, onConfirm: (date) {
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                    if(picked != null) {
                      setState(() {
                        this.time = picked;
                      });
                    }
                  },
                ),
              ),
            ),
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
                  setState(() {
                    if(value.isEmpty){
                      isValid = false;
                    }else{
                      isValid = true;
                    }
                  });
                },
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration.collapsed(
                    hintText: "Nhập chỉ số đường huyết"
                ),
              ),
              trailing: Text("mg/dL",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                icon: Icon(Icons.add_circle, color: Colors.blue),
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
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(56),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.lightBlue,
                onPressed: () async {
                  try {
                    value = double.tryParse(indexG.text);
                    if (value <= 0){
                      Fluttertoast.showToast(
                          msg: "Giá trị đường huyết không hợp lệ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {
                      await updateGlycemic();
                      Navigator.pop(context, glycemicModelBack);
                    }
                  } catch (ex){
                    Fluttertoast.showToast(
                        msg: "Giá trị đường huyết không đúng",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: Text(
                  "Cập nhật",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
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
                    SizedBox(height:15),
                    Container(
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: <Widget>[
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
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

}
