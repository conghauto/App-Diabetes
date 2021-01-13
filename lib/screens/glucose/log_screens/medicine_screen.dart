import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../user_current.dart';
import '../../../constants.dart';
import '../add_log_screen.dart';
class MedicineLog extends StatefulWidget{
  MedicineLog({ Key key }) : super(key: key);
  @override
  MedicineLogState createState() {
    return MedicineLogState();
  }
}
class MedicineLogState extends State<MedicineLog> with AutomaticKeepAliveClientMixin{
  bool isInsulin = false;
  List<String> listInsulin = ["Tác dụng nhanh", "Tác dụng ngắn", "Tác dụng trung bình", "Tác dụng dài"];
  String typeOfInsulin = "";
  bool _selectedFast = false;
  bool _selectedShort = false;
  bool _selectedMedium = false;
  bool _selectedLong = false;

  String typeOfUnit = "";
  bool _selectedVienNen = false;
  bool _selectedNhong = false;
  bool _selectedNgam = false;
  bool _selectedMg = false;
  bool _selectedAnother = false;

  bool isValid=false;
  TextEditingController name;
  TextEditingController amount;
  TextEditingController note;
  @override
  void initState(){
    super.initState();
    amount = TextEditingController(text:"");
    name = TextEditingController(text:"");
    note = TextEditingController(text:"");
    setState(() {
      isValid = false;
    });
  }
  void checkCondition(){
    try {
      String text = name.text;
      text = text.trim();
      text = text.replaceAll(" ", "");
      double value = double.tryParse(amount.text);
      if (value <= 0 || text.length <= 0 || text.isEmpty ){
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
  void addMedicine()async{
    var url = ip + "/api/addMedicine.php";
    var response = await http.post(url, body: {
      'name': name.text,
      'typeInsulin': typeOfInsulin,
      'unit': typeOfUnit,
      'note': note.text,
      'amount': amount.text,
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

    }
  }

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
              "Tên thuốc",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: TextField(
              controller: name,
              onChanged: (value){
                checkCondition();
              },
              textAlign: TextAlign.right,
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập tên thuốc"
              ),
            ),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            leading: Text(
              "Thuốc có chứa Insulin?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: SizedBox(),
            trailing: Switch(
              activeColor: Colors.lightGreen,
              value: isInsulin,
              onChanged: (value){
                setState(() {
                  isInsulin = value;
                  if (isInsulin == false){
                     typeOfInsulin = "";
                     _selectedFast = false;
                     _selectedShort = false;
                     _selectedMedium = false;
                     _selectedLong = false;
                  }
                });
              },
            ),
          ),
          (isInsulin == true) ?
          Column(
            children: [
              Divider(
                height: 5,
                color: Colors.black,
              ),
              ListTile(
                leading: Text(
                  "Loại Insulin?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Container(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 3,
                    runSpacing: 3,
                    children: [
                      ChoiceChip(
                        label: Text("Tác dụng nhanh"),
                        selected: _selectedFast,
                        onSelected: (value) => {
                          this.setState(() {
                            _selectedFast = true;
                            _selectedShort = false;
                            _selectedMedium = false;
                            _selectedLong = false;
                            typeOfInsulin = "Tác dụng nhanh";
                          })
                        },
                      ),
                      ChoiceChip(
                        label: Text("Tác dụng ngắn"),
                        selected: _selectedShort,
                        onSelected: (value) => {
                          this.setState(() {
                            _selectedFast = false;
                            _selectedShort = true;
                            _selectedMedium = false;
                            _selectedLong = false;
                            typeOfInsulin = "Tác dụng ngắn";
                          })
                        },
                      ),
                      ChoiceChip(
                        label: Text("Tác dụng trung bình"),
                        selected: _selectedMedium,
                        onSelected: (value) => {
                          this.setState(() {
                            _selectedFast = false;
                            _selectedShort = false;
                            _selectedMedium = true;
                            _selectedLong = false;
                            typeOfInsulin = "Tác dụng trung bình";
                          })
                        },
                      ),
                      ChoiceChip(
                        label: Text("Tác dụng dài"),
                        selected: _selectedLong,
                        onSelected: (value) => {
                          this.setState(() {
                            _selectedFast = false;
                            _selectedShort = false;
                            _selectedMedium = false;
                            _selectedLong = true;
                            typeOfInsulin = "Tác dụng dài";
                          })
                        },
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 5,
                color: Colors.black,
              ),
            ],

          )
          :
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            leading: Text(
              "Dạng thuốc",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Container(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 3,
                runSpacing: 3,
                children: [
                  ChoiceChip(
                    label: Text("Viên"),
                    selected: _selectedVienNen,
                    onSelected: (value) => {
                      this.setState(() {
                        _selectedVienNen = true;
                        _selectedNhong = false;
                        _selectedNgam = false;
                        _selectedMg = false;
                        _selectedAnother = false;
                        typeOfUnit = "Viên";
                      })
                    },
                  ),
                  ChoiceChip(
                    label: Text("Nhộng"),
                    selected: _selectedNhong,
                    onSelected: (value) => {
                      this.setState(() {
                        _selectedVienNen = false;
                        _selectedNhong = true;
                        _selectedNgam = false;
                        _selectedMg = false;
                        _selectedAnother = false;
                        typeOfUnit = "Nhộng";
                      })
                    },
                  ),
                  ChoiceChip(
                    label: Text("Ngậm"),
                    selected: _selectedNgam,
                    onSelected: (value) => {
                      this.setState(() {
                        _selectedVienNen = false;
                        _selectedNhong = false;
                        _selectedNgam = true;
                        _selectedMg = false;
                        _selectedAnother = false;
                        typeOfUnit = "Ngậm";
                      })
                    },
                  ),
                  ChoiceChip(
                    label: Text("Mg"),
                    selected: _selectedMg,
                    onSelected: (value) => {
                      this.setState(() {
                        _selectedVienNen = false;
                        _selectedNhong = false;
                        _selectedNgam = false;
                        _selectedMg = true;
                        _selectedAnother = false;
                        typeOfUnit = "Mg";
                      })
                    },
                  ),
                  ChoiceChip(
                    label: Text("Khác"),
                    selected: _selectedAnother,
                    onSelected: (value) => {
                      this.setState(() {
                        _selectedVienNen = false;
                        _selectedNhong = false;
                        _selectedNgam = false;
                        _selectedMg = false;
                        _selectedAnother = true;
                        typeOfUnit = "Khác";
                      })
                    },
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            leading: Text(
              "Liều lượng",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: TextField(
              textAlign: TextAlign.right,
              controller: amount,
              onChanged: (value){
                checkCondition();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập liều lượng"
              ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}