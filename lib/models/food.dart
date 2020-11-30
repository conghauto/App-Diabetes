
class FoodModel{
  final String id;
  final String name;
  final String image;
  final String ingredient;
  final String recipe;
  final String benefit;
  final String groupID;

  FoodModel({this.id, this.name, this.image, this.ingredient, this.recipe,this.benefit,this.groupID, });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'].toString(),
      image: json['image'].toString(),
      ingredient: json['ingredient'].toString(),
      recipe: json['recipe'].toString(),
      benefit: json['benefit'].toString(),
      groupID: json['groupID'].toString()
    );
  }
}