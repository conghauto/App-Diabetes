import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:diabetesapp/extensions/format_datetime.dart';
import 'package:diabetesapp/models/medicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../size_config.dart';
import '../../../user_current.dart';
import '../../../constants.dart';
import '../add_log_screen.dart';
class UpdateMedicine extends StatefulWidget{
  static String routeName = "/update_medicine_screen";
  UpdateMedicine({this.medicineModel});
  MedicineModel medicineModel;
  @override
  _UpdateMedicineState createState() {
    return _UpdateMedicineState();
  }
}
class _UpdateMedicineState extends State<UpdateMedicine> {
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
  String ID;
  TextEditingController amount;
  TextEditingController note;
  DateTime time;
  @override
  void initState(){
    super.initState();
    amount = TextEditingController(text: widget.medicineModel.amount);
    name = TextEditingController(text: widget.medicineModel.name);
    note = TextEditingController(text: widget.medicineModel.note);
    ID = widget.medicineModel.id;
    time = widget.medicineModel.measureTime;
    typeOfUnit = widget.medicineModel.unit;
    if (typeOfUnit.length > 0){
      switch(typeOfUnit) {
        case "Viên":
          _selectedVienNen = true;
          break;
        case "Nhộng":
          _selectedNhong = true;
          break;
        case "Ngậm":
          _selectedNgam = true;
          break;
        case "Mg":
          _selectedMg = true;
          break;
        case "Khác":
          _selectedAnother = true;
          break;
      }
    }
    typeOfInsulin = widget.medicineModel.typeInsulin;
    if (typeOfInsulin.length >0) {
      isInsulin = true;
      switch(typeOfInsulin) {
        case "Tác dụng nhanh":
          _selectedFast = true;
          break;
        case "Tác dụng ngắn":
          _selectedShort = true;
          break;
        case "Tác dụng trung bình":
          _selectedMedium = true;
          break;
        case "Tác dụng dài":
          _selectedLong = true;
          break;
      }
    }
  }
  void checkCondition(){
    if (amount.text.length <= 0 || name.text.length <= 0 || typeOfUnit.length <= 0) {
      setState(() {
        isValid = false;
      });
    } else {
      setState(() {
        isValid = true;
      });
    }
  }
  void updateMedicine()async{
    var url = ip + "/api/updateMedicine.php";
    var response = await http.post(url, body: {
      'name': name.text,
      'typeInsulin': typeOfInsulin,
      'unit': typeOfUnit,
      'note': note.text,
      'amount': amount.text,
      'measureTime': time.toString(),
      'id': ID,
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
          msg: "Cập nhật thuốc thành công",
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
          title: Text("Update Thuốc")
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
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(56),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.lightBlue,
                onPressed: () async {
                  await updateMedicine();
                  Navigator.pop(context);
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


}