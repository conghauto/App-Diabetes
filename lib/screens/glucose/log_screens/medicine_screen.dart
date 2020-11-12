import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MedicineLog extends StatefulWidget{

  @override
  _MedicineLogState createState() {
    return _MedicineLogState();
  }
}
class _MedicineLogState extends State<MedicineLog>{
  bool isInsulin = false;
  List<String> listInsulin = ["Bolus", "Basal"];
  bool _selected = false;
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
                });
              },
            ),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          (isInsulin == true) ?
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
                      label: Text("Bolus"),
                      selected: !_selected,
                      onSelected: (value) => {
                        this.setState(() {
                          _selected = !value;
                        })
                      },
                  ),
                  ChoiceChip(
                      label: Text("Basal"),
                      selected: _selected,
                      onSelected: (value) => {
                      this.setState(() {
                        _selected = value;
                      })
                    },
                  )
                ],
              ),
            ),
          )
          :
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
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập liều lượng"
              ),
            ),
          ),
        ],
      ),
    );
  }

}