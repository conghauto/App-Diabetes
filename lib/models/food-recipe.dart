
class FoodRecipeModel{
  final String id;
  final String name;
  final String ingredient;
  final String recipe;
  final String benefit;
  final String groupID;

  FoodRecipeModel({this.id, this.name,this.ingredient, this.recipe,this.benefit,this.groupID, });

  factory FoodRecipeModel.fromJson(Map<String, dynamic> json) {
    return FoodRecipeModel(
      id: json['id'],
      name: json['name'].toString(),
      ingredient: json['ingredient'].toString(),
      recipe: json['recipe'].toString(),
      benefit: json['benefit'].toString(),
      groupID: json['groupID'].toString()
    );
  }
}