import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarbsLog extends StatelessWidget{
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
              textAlign: TextAlign.right,
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
              textAlign: TextAlign.right,
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
              textAlign: TextAlign.right,
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
              textAlign: TextAlign.right,
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
              onPressed: () => {

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
              textAlign: TextAlign.right,
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

}