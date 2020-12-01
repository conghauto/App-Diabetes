import 'dart:convert';

import 'package:diabetesapp/models/sport.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/sport_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<SportModel> listSports = new List();

  @override
  void initState() {
    fetchSports();
  }
  Future<void> fetchSports() async {
    String url = ip + "/api/getSports.php";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<SportModel> list = items.map<SportModel>((json) {
        return SportModel.fromJson(json);
      }).toList();
      if (list != null) {
        setState(() {
          listSports = list;
        });
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return _myListView(context, listSports);
  }
}

Widget _myListView(BuildContext context, List<SportModel> data) {

  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => SportDetail(sportModel: data[index])));
        },
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [kBoxShadow],
          ),
          child: Row(
            children: [

              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildRecipeTitle(data[index].name),
                      buildRecipeSubTitle(data[index].benefit),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}