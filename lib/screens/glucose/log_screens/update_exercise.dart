import 'dart:convert';
import 'package:diabetesapp/components/choice_chip_widget.dart';
import 'package:diabetesapp/components/multi_choice_chip.dart';
import 'package:diabetesapp/constants.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:diabetesapp/models/activity.dart';
import 'package:diabetesapp/models/type-exercise.dart';
import 'package:diabetesapp/screens/glucose/add_log_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/add_tab_screen.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../size_config.dart';

class UpdateExercise extends StatefulWidget{
  static String routeName = "/update_exercise_screen";
  UpdateExercise({this.activityModel});
  ActivityModel activityModel;
  @override
  _UpdateExerciseState createState() {
    return _UpdateExerciseState();
  }
}
class _UpdateExerciseState extends State<UpdateExercise> {
  ActivityModel activityModelBack;
  List<TypeExerciseModel> listTypeExercises;
  TypeExerciseModel selectedTypeExercise;

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
  double value = -1;
  String id = "";
  TextEditingController note;
  TextEditingController timeActivity;
  bool isValidTime=false;
  bool isValidType=false;
  DateTime time;

  Future<void> fetchTypeExercise() async {
    listTypeExercises = new List<TypeExerciseModel>();

    String url = ip + "/api/data/index-mets.json";
    var response = await http.get(url,headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final items = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();

      List<TypeExerciseModel> list = items.map<TypeExerciseModel>((json) {
        return TypeExerciseModel.fromJson(json);
      }).toList();

      setState(() {
        listTypeExercises = list;
      });
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  @override
  void initState() {
    note = TextEditingController(text: widget.activityModel.note);
    timeActivity = TextEditingController(text: widget.activityModel.timeActivity);
    id = widget.activityModel.id;
    time = widget.activityModel.measureTime;
    String listTags = widget.activityModel.tags;
    if (listTags.length > 0){
      listTags = listTags.substring(1, listTags.length - 1);
      if (listTags.contains(",")){
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
    selectedTypeExercise = new TypeExerciseModel(id: '', typeExercise: widget.activityModel.nameActivity, mETs: widget.activityModel.indexMET);
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
          title: Text("Update hoạt động")
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
              height: 20,
            ),
            ListTile(
              leading: Text(
                "Loại hoạt động",
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
                    hintText: selectedTypeExercise!=null? selectedTypeExercise.typeExercise: "Add",
                    enabled: false
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                    Icons.add_circle,
                    color: Colors.blue),
                tooltip: "Thêm mới",
                onPressed: () async {
                  await showTypesExercise(context);
                },
              ),
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Thời gian",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Colors.blue[900],
                ),
              ),
              title: TextField(
                keyboardType: TextInputType.number,
                controller: timeActivity,
                onChanged: (value){
                  setState(() {
                    if(value.isEmpty){
                      isValidTime = false;
                    }else{
                      isValidTime =true;
                    }
                  });
                },
                textAlign: TextAlign.right,
                decoration: InputDecoration.collapsed(
                    hintText: "Nhập thời gian hoạt động"
                ),
              ),
              trailing: Text("/phút",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
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
                    Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: InputChip(
                          backgroundColor: Colors.blue,
                          avatar: Icon(Icons.edit_outlined),
                          label: Text("Sửa", style:
                          TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                          onSelected: (_) async {
                            await showDialogFunc(context);
                          }
                      ),
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
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(56),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.lightBlue,
                onPressed: () async {
                  try {
                    value = double.tryParse(timeActivity.text);
                    if (value <= 0){
                      Fluttertoast.showToast(
                          msg: "Thời gian hoạt động không hợp lệ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {
                      await updateActivity();
                      Navigator.pop(context, activityModelBack);
                    }
                  } catch (ex){
                    Fluttertoast.showToast(
                        msg: "Thời gian hoạt động không hợp lệ",
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

  void updateActivity() async{
    var url = ip + "/api/updateActivity.php";
    var response = await http.post(url, body: {
      'nameActivity': selectedTypeExercise.typeExercise.toString(),
      'indexMET': selectedTypeExercise.mETs.toString(),
      'timeActivity': timeActivity.text,
      'tags': selectedReportList.length==0?"":selectedReportList.toString(),
      'note': note.text,
      'measureTime': time.toString(),
      'id': id,
      'userID': widget.activityModel.userID
    });
    activityModelBack = new ActivityModel(id: id, nameActivity: selectedTypeExercise.typeExercise.toString(),
        indexMET: selectedTypeExercise.mETs.toString(), timeActivity: timeActivity.text,
        tags: selectedReportList.length==0?"":selectedReportList.toString(), note: note.text, measureTime: time, calo: widget.activityModel.calo, userID: widget.activityModel.userID, idModel: widget.activityModel.idModel);
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
          msg: "Cập nhật thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  showTypesExercise(context) async{
    await fetchTypeExercise();
    return showDialog(
        context: context,
        builder: (context){
          return Scaffold(
              appBar: AppBar(
                title: const Text('Hoạt động'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 4.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            color: (index%2!=0?Colors.teal[100 * (index % 9)]:Colors.yellow[100 * (index % 9)]),
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  isValidType =true;
                                  selectedTypeExercise = listTypeExercises[index];
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(listTypeExercises[index].typeExercise,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: listTypeExercises.length,
                      ),
                    ),
                  ],
                ),
              )
          );
        }
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