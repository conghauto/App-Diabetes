import 'package:diabetesapp/components/multi_choice_chip.dart';
import 'package:diabetesapp/screens/glucose/log_screens/add_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseLog extends StatefulWidget{
  ExerciseLog({ Key key }) : super(key: key);
  @override
  ExerciseLogState createState() {
    return ExerciseLogState();
  }
}
class ExerciseLogState extends State<ExerciseLog> with AutomaticKeepAliveClientMixin{
  List<String> reportList = [
    "Not relevant",
    "Illegal",
    "Spam",
    "Offensive",
    "Uncivil"
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
              "Loại hoạt động",
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
              "Thời gian",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration.collapsed(
                  hintText: "Nhập thời gian hoạt động"
              ),
            ),
            trailing: Text("phút"),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}