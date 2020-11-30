import 'dart:convert';

import 'package:diabetesapp/models/food.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/food_recipe.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<FoodModel> listFoods = new List();

  @override
  void initState() {
    fetchFoods();
  }
  Future<void> fetchFoods() async {
    String url = ip + "/api/getFoods.php";
    var response = await http.get(url);

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
    return _myListView(context, listFoods);
  }
}

Widget _myListView(BuildContext context, List<FoodModel> data) {

  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeFood(recipe: data[index])));
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