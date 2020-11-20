import 'package:flutter/material.dart';

class SelectFilter extends StatefulWidget {
  final List<dynamic> listItems;

  SelectFilter({Key key, this.listItems}) : super(key: key);

  @override
  _SelectFilterState createState() => _SelectFilterState();
}

class _SelectFilterState extends State<SelectFilter> {
  var tmpArray = [];

  Map<String, bool> valuesOfDateTime = {
    'Tất cả': false,
    'Chọn ngày': false,
  };

  Map<String, bool> valuesOfType = {
    'Tất cả': false,
    'Đường huyết': false,
    'Thức ăn': false,
    'Thuốc': false,
    'Cân nặng': false,
    'Hoạt động': false,
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
                Navigator.pop(context);
              });
            },
          ),
        ),
        body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
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
                      Expanded(child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: valuesOfDateTime.keys.map((String key) {
                            return new CheckboxListTile(
                              title: new Text(key),
                              value: valuesOfDateTime[key],
                              activeColor: Colors.pink,
                              checkColor: Colors.white,
                              onChanged: (bool value) {
                                setState(() {
                                  valuesOfDateTime[key] = value;
                                });
                              },
                            );
                          }).toList()
                      )),
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
                            physics: const NeverScrollableScrollPhysics(),
                            children: valuesOfType.keys.map((String key) {
                              return new CheckboxListTile(
                                title: new Text(key),
                                value: valuesOfType[key],
                                activeColor: Colors.pink,
                                checkColor: Colors.white,
                                onChanged: (bool value) {
                                  setState(() {
                                    valuesOfType[key] = value;
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
}

