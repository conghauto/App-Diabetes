import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:diabetesapp/models/sport.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/sport_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import '../../../constants.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<SportModel> listSports = new List();
  ProgressDialog progressDialog;
  bool isConnected = true;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    progressDialog.style(message: "Kiểm tra kết nối Internet");
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    fetchSports();
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
      setState(() {
        isConnected = true;
      });
      checkInternet();
    } else {
      setState(() {
        isConnected = false;
      });
      checkInternet();
    }
  }
  void checkInternet(){
    if (isConnected) {
      progressDialog.hide();
    } else {
      progressDialog.show();
    }
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
                  borderRadius: BorderRadius.circular(30),
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
                      buildSportSubTitle(data[index].benefit),
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