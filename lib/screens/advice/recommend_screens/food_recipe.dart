import 'package:diabetesapp/models/food.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecipeFood extends StatefulWidget {
  static String routeName = "/recipe_food_screen";
  FoodModel recipe;
  RecipeFood({this.recipe});
  @override
  _RecipeFoodState createState() {
    // TODO: implement createState
    return new _RecipeFoodState();
  }
}
class _RecipeFoodState extends State<RecipeFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          tooltip: 'Đóng',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite_border,
              color: Colors.black,
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
                  buildTextTitleVariation1(widget.recipe.name),
                  buildTextSubTitleVariation1(widget.recipe.benefit),
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
                image: DecorationImage(
                  image: NetworkImage(widget.recipe.image),
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
                  buildTextTitleVariation2('Nguyên liệu', false),
                  buildTextSubTitleVariation1(widget.recipe.ingredient),

                  SizedBox(height: 16),

                  buildTextTitleVariation2('Cách làm', false),
                  buildTextSubTitleVariation1(widget.recipe.recipe),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}