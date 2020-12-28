import 'dart:convert';

import 'package:diabetesapp/models/food-recipe.dart';
import 'package:diabetesapp/models/food.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../user_current.dart';

// ignore: must_be_immutable
class RecipeFood extends StatefulWidget {
  static String routeName = "/recipe_food_screen";
  FoodModel foodModel;
  RecipeFood({this.foodModel});
  @override
  _RecipeFoodState createState() {
    // TODO: implement createState
    return new _RecipeFoodState(recipeFood: foodModel);
  }
}
class _RecipeFoodState extends State<RecipeFood> {
  _RecipeFoodState({this.recipeFood});
  FoodRecipeModel foodRecipeModel = new FoodRecipeModel(id: "", name: "", ingredient: "", recipe: "", benefit: "", groupID: "");
  FoodModel recipeFood;
  FlutterTts voice = FlutterTts();
  bool isPlaying = false;
  @override
  void initState() {
    fetchRecipe();
    configureVoice();
  }
  Future configureVoice() async {
    voice.setLanguage("vi-VN");
    voice.setPitch(1);
    voice.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    voice.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    voice.setErrorHandler((err) {
      setState(() {
        isPlaying = false;
      });
    });
  }
  Future _speak(String text) async {
    if (text != null && text.isNotEmpty) {
      var result = await voice.speak(text);
      if (result == 1)
        setState(() {
          isPlaying = true;
        });
    }
  }

  Future _stop() async {
    var result = await voice.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
  }
  @override
  void dispose() {
    super.dispose();
    voice.stop();
  }

  void addCarb() async {
    var url = ip + "/api/addCarb.php";
    var response = await http.post(url, body: {
      'carb': recipeFood.carb,
      'fat': recipeFood.lipid,
      'protein': recipeFood.protein,
      'calo': recipeFood.calo,
      'tags': "",
      'note': recipeFood.name,
      'measureTime': DateTime.now().toString(),
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
      Fluttertoast.showToast(
          msg: "Thêm thức ăn thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  fetchRecipe() async {
    String url = ip + "/api/getRecipeByID.php";
    var response = await http.post(url, body: {
      'groupID': recipeFood.id,
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      FoodRecipeModel item = FoodRecipeModel.fromJson(items[0]);
      setState(() {
        foodRecipeModel = item;
      });
    } else {
      throw Exception('Failed to load data.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          tooltip: 'Đóng',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () => {
                showAddFood(context)
              },
              icon: Icon(Icons.add_box_outlined),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1(widget.foodModel.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTextTitleVariation2("Công dụng", false),
                    IconButton(
                      iconSize: 30,
                      autofocus: true,
                      tooltip: "Nhấn để nghe",
                      icon: (!isPlaying) ? Icon(Icons.play_arrow, color: Colors.green,) : Icon(Icons.stop, color: Colors.red,),
                      onPressed: () async{
                        String content = "Tên món ăn " + widget.foodModel.name;
                        content += "Công dụng " + foodRecipeModel.benefit;
                        content += "Thành phần dinh dưỡng ";
                        content += "Chất béo " + recipeFood.lipid + " g";
                        content += "Chất xơ " + recipeFood.cellulose  + " g";
                        content += "Chất đạm " + recipeFood.protein  + " g";
                        content += "Carbon hydrat " + recipeFood.carb  + " g";
                        if (foodRecipeModel.ingredient.length > 0) {
                          content += "Nguyên liệu " + foodRecipeModel.ingredient;
                        }
                        if (foodRecipeModel.recipe.length > 0) {
                          content += "Công thức " + foodRecipeModel.recipe;
                        }
                        setState(() {
                          (isPlaying) ? _stop() : _speak(content);
                        });
                      },
                    )
                  ],),
                  buildTextSubTitleVariation1(foodRecipeModel.benefit),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 310,
              width: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(widget.foodModel.image),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation2("Thành phần dinh dưỡng", false),
                  buildTextSubTitleVariation1("Chất béo: " + recipeFood.lipid + " g"),
                  buildTextSubTitleVariation1("Chất xơ: " + recipeFood.cellulose + " g"),
                  buildTextSubTitleVariation1("Carbon Hydrat: " + recipeFood.carb + " g"),
                  buildTextSubTitleVariation1("Chất đạm: " + recipeFood.protein + " g"),
                  (foodRecipeModel.ingredient.length > 0) ?
                  Column(
                    children: [
                      buildTextTitleVariation2('Nguyên liệu', false),
                      buildTextSubTitleVariation1(foodRecipeModel.ingredient),
                    ],
                  ) : SizedBox(height: 1,),
                  SizedBox(height: 16),
                  (foodRecipeModel.recipe.length > 0) ?
                  Column(
                    children: [
                      buildTextTitleVariation2('Cách làm', false),
                      buildTextSubTitleVariation1(foodRecipeModel.recipe),
                    ],
                  ) : SizedBox(height: 1,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  showAddFood(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Hủy"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () async {
        addCarb();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("XÁC NHẬN"),
      content: Text("Bạn có muốn thêm món ăn vào lịch sử hằng ngày?"),
      actions: [
        continueButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}