import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:diabetesapp/components/choice_chip_widget.dart';
import 'package:diabetesapp/components/multi_choice_chip.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:diabetesapp/models/carb.dart';
import 'package:diabetesapp/screens/glucose/log_screens/add_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../add_log_screen.dart';
class UpdateCarbs extends StatefulWidget{
  static String routeName = "/update_carbs_screen";
  UpdateCarbs({this.carbModel});
  CarbModel carbModel;
  @override
  _UpdateCarbsState createState() {
    return _UpdateCarbsState();
  }
}
class _UpdateCarbsState extends State<UpdateCarbs> {
  CarbModel carbModelBack;
  double valueCarb = -1;
  double valueFat = -1;
  double valueProtein = -1;
  double valueCalo = -1;
  TextEditingController carb;
  TextEditingController fat;
  TextEditingController protein;
  TextEditingController calo;
  String id ="";
  TextEditingController note;
  DateTime time;
  bool isValid=false;
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
  void initState(){
    super.initState();
    note = TextEditingController(text: widget.carbModel.note);
    calo = TextEditingController(text: widget.carbModel.calo);
    carb = TextEditingController(text: widget.carbModel.carb);
    fat = TextEditingController(text: widget.carbModel.fat);
    protein = TextEditingController(text: widget.carbModel.protein);
    id = widget.carbModel.id;
    time = widget.carbModel.measureTime;
    String listTags = widget.carbModel.tags;
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

  void checkCondition(){
    if (carb.text.length <= 0 || calo.text.length <= 0 || fat.text.length <= 0 || protein.text.length <= 0) {
      setState(() {
        isValid = false;
      });
    } else {
      setState(() {
        isValid = true;
      });
    }
  }
  void updateCarb()async{
    var url = ip + "/api/updateCarb.php";
    var response = await http.post(url, body: {
      'carb': carb.text,
      'fat': fat.text,
      'protein': protein.text,
      'calo': calo.text,
      'tags': selectedReportList.length==0?"":selectedReportList.toString(),
      'note': note.text,
      'measureTime': time.toString(),
      'id': id,
    });
    carbModelBack = new CarbModel(id: id, carb: carb.text, fat: fat.text, protein: protein.text, calo: calo.text, tags: selectedReportList.length==0?"":selectedReportList.toString(), note: note.text, userID: widget.carbModel.userID, measureTime: time, idModel: widget.carbModel.idModel);
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
          msg: "Cập nhật Carbs thành công",
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
          title: Text("Cập nhật")
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
                "Carbs",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16, fontWeight: FontWeight.bold
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
              trailing: Text("g",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Colors.black)
              ),
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Chất béo",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16, fontWeight: FontWeight.bold
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
              trailing: Text("g",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Colors.black)
              ),
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Protein",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16, fontWeight: FontWeight.bold
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
              trailing: Text("g",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Colors.black)
              ),
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Calories",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16, fontWeight: FontWeight.bold
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
              trailing: Text("kCal",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Colors.black)
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
                    fontFamily: 'Roboto',
                    fontSize: 16, fontWeight: FontWeight.bold
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top:10),
                child: TextField(
                  controller: note,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  decoration: InputDecoration.collapsed(
                    hintText: "Nhập ghi chú",
                  ),
                ),
              ),
              trailing: Icon(Icons.note),
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(56),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.blueAccent,
                onPressed: () async {
                  try {
                    valueCarb = double.tryParse(carb.text);
                    valueFat = double.tryParse(fat.text);
                    valueProtein = double.tryParse(protein.text);
                    valueCalo = double.tryParse(calo.text);
                    if (valueCarb < 0 || valueFat < 0 || valueProtein < 0 || valueCalo < 0){
                      Fluttertoast.showToast(
                          msg: "Giá trị không hợp lệ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {
                      await updateCarb();
                      Navigator.pop(context, carbModelBack);
                    }
                  } catch (ex){
                    Fluttertoast.showToast(
                        msg: "Giá trị không hợp lệ",
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
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Container(
//                        child: Text(
//                          'Thêm tags để tạo log',
//                          style: TextStyle(color: Colors.black, fontSize: 18.0),
//                        ),
//                      ),
//                    ),
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