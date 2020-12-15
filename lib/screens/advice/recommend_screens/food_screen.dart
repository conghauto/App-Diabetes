import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:diabetesapp/models/food-recipe.dart';
import 'package:diabetesapp/models/food.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/food_recipe.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../user_current.dart';

class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<FoodModel> listFoods;
  List<String> categories = ["Bữa sáng", "Bữa trưa", "Bữa tối", "Bữa phụ"];
  int selectedIndex = 0;

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
    fetchFoods();
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
  Future<void> fetchFoods() async {
    listFoods = new List();
    String url = ip + "/api/getBreakfast.php";
    switch(selectedIndex.toString()){
      case "0":
        url = ip + "/api/getBreakfast.php";
        break;
      case "1":
        url = ip + "/api/getLunch.php";
        break;
      case "2":
        url = ip + "/api/getDinner.php";
        break;
      case "3":
        url = ip + "/api/getSnack.php";
        break;
    }

    var response = await http.post(url, body: {
      'userID': UserCurrent.userID.toString(),
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<FoodModel> list = items.map<FoodModel>((json) {
        return FoodModel.fromJson(json);
      }).toList();
      if (list != null) {
        setState(() {
          listFoods = list;
        });
      }
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
              child: SizedBox(
                height: SizeConfig.defaultSize * 3.5, // 35
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => buildCategoriItem(index),
                ),
              ),
            ),
            Expanded(child:_myListView(context, listFoods)),
          ],
    );
  }
  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          fetchFoods();
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 2, //20
          vertical: SizeConfig.defaultSize * 0.5, //5
        ),
        decoration: BoxDecoration(
            color:
            selectedIndex == index ? Color(0xFFEFF3EE) : Colors.white,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6, // 16
            )),
        child: Text(
          categories[index],
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.red : Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }
}

Widget _myListView(BuildContext context, List<FoodModel> data) {

  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeFood(foodModel: data[index])));
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
                height: 150,
                width: 150,
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
                      buildRecipeSubTitle(data[index].amount + " " + data[index].unit),
                      buildCalories(data[index].calo),
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